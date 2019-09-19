tag:
	. gradle.properties; \
	git tag $${git_tag_version}
	git push origin $${git_tag_version}

build:
	./gradlew clean build -x test
    
auth-server-docker: build
	./scripts/build.sh build jy-auth-server;
	
web-server-docker: build
	./scripts/build.sh build jy-web-server;

article-docker: build-article
	./scripts/build.sh build article;

story-docker: build-story
	./scripts/build.sh build story;

portal-docker: build-portal
	./scripts/build.sh build portal;

upload-story: story-docker 
	./scripts/build.sh upload story;

upload-portal: portal-docker 
	./scripts/build.sh upload portal;

upload-auth-server: auth-server-docker
	./scripts/build.sh upload jy-auth-server;

upload-web-server: web-server-docker
	./scripts/build.sh upload jy-web-server;

build-article:
	./gradlew clean :article:jy-article-api:build -x test; \
	./scripts/fix-module-info-missing jy-article-api article;

build-portal:
	./gradlew clean :common:application:jy-portal-spring-boot-app:build -x test; \
	./scripts/fix-module-info-missing jy-portal-spring-boot-app .;
	
build-story:
	./gradlew clean :story:jy-story-api:build -x test; \
	./scripts/fix-module-info-missing jy-story-api story;

build-base-docker:
	docker build -f ./scripts/Dockerfile.jlink -t jdk-base-alpine .

dangling:
	docker rmi -f $$(docker images -q -f dangling=true )

jib:
	./gradlew :common:application:webapp:jy-auth-server:jib

swagger:
	cd ./scripts/swagger; ./server_code	


javafx-build:
	./gradlew :story:jy-story-javafx-app:clean \
	:story:jy-story-javafx-app:build \
	:story:jy-story-javafx-app:jlink

mac-app: javafx-build
	build_dir=story/jy-story-javafx-app/build; \
	/Users/evan/Documents/workspace/jiayi/java/jdk.packager-osx/jpackager \
	create-image --verbose --echo-mode \
	--output $${build_dir} \
	--runtime-image $${build_dir}/image \
	--module-path $${build_dir}/jlinkbase/jlinkjars \
	--add-modules java.base,java.desktop,java.xml,jdk.unsupported \
	--module jy.story.javafx.app/com.buyou.game.StoryEditorApplication \
	--name StoryApp

xmac-app2: 
	build_dir=story/jy-story-javafx-app/build; \
	/Users/evan/Documents/workspace/jiayi/java/jdk.packager-osx/jpackager \
	create-image --verbose --echo-mode \
	--output $${build_dir} \
	--module-path $${build_dir}/jlinkbase/jlinkjars \
	--add-modules java.base,java.desktop,java.xml,jdk.unsupported \
	--module jy.story.javafx.app/com.buyou.game.StoryEditorApplication \
	--name StoryApp2

xmac-app3:
	build_dir=story/jy-story-javafx-app/build; \
	/Users/evan/Documents/workspace/jiayi/java/jdk.packager-osx/jpackager \
	create-installer --verbose --echo-mode \
	--output $${build_dir} \
	--install-dir /Users/evan/Documents/workspace/jiayi/java/jiayi/jy-story-javafx-app/build/test \
	--runtime-image $${build_dir}/image \
	--module-path $${build_dir}/jlinkbase/jlinkjars \
	--add-modules java.base,java.desktop,java.xml,jdk.unsupported \
	--module jy.story.javafx.app/com.buyou.game.StoryEditorApplication \
	--name StoryApp
