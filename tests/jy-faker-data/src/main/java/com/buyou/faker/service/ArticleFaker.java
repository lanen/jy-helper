package com.buyou.faker.service;

import com.buyou.article.dao.ContentRepository;
import com.buyou.article.dao.ContentSummaryRepository;
import com.buyou.article.model.Content;
import com.buyou.article.model.ContentSummary;
import com.buyou.article.model.ContentType;
import com.buyou.id.SnowflakeIdGenerator;
import io.codearte.jfairy.Fairy;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * @author evan
 * @date 2019-01-31
 */
@Service
public class ArticleFaker {

    private static final Logger logger = LoggerFactory.getLogger(ArticleFaker.class);

    @Autowired
    private ContentRepository contentRepository;

    @Autowired
    public TaskExecutor taskExecutor;

    @Autowired
    private ContentSummaryRepository contentSummaryRepository;

    ExecutorService executorService = Executors.newFixedThreadPool(5);

    @PostConstruct
    public void init(){

//        for (int i=0;i<5;i++){
//            taskExecutor.execute( new RunIt(1000000));
//            taskExecutor.execute( new RunIt(1000000));
//            taskExecutor.execute( new RunIt(1000000));
//            taskExecutor.execute( new RunIt(1000000));
//        }
        new RunIt(10000);
//        executorService.execute(new RunIt(1000000, contentRepository, contentSummaryRepository));
//        executorService.execute(new RunIt(1000000, contentRepository, contentSummaryRepository));
//        executorService.execute(new RunIt(1000000, contentRepository, contentSummaryRepository));
//        executorService.execute(new RunIt(1000000, contentRepository, contentSummaryRepository));
//        executorService.execute(new RunIt(1000000));

    }

    public class RunIt implements Runnable{
        final int count;

        public RunIt(int count) {
            this.count = count;
        }

        @Override
        public void run() {
            try{
                logger.info("start faker");
                Fairy fairy = Fairy.create();
                for (int i = 0; i <count; i++) {
                    save(fairy);
                }
                logger.info("end of faker");

            }catch (Exception e){
                e.printStackTrace();
            }

        }

    }

    SnowflakeIdGenerator generator = new SnowflakeIdGenerator(0,0);

    void save(Fairy fairy ){
        Long contentId = generator.nextId();
        Long authorId = generator.nextId();

        Content content = new Content();
        content.setContentId(contentId);
        content.setAuthorId(authorId);
        content.setContentType(ContentType.MARKDOWN);

        content.setContent(fairy.textProducer().sentence());

        ContentSummary contentSummary = new ContentSummary();
        contentSummary.setAuthorId(authorId);
        contentSummary.setContentId(contentId);
        contentSummary.setTitle(fairy.textProducer().sentence());
        contentSummary.setSummary(fairy.textProducer().sentence());
        contentSummary.setCreateTime((int) (System.currentTimeMillis()/1000));
        contentSummary.setUpdateTime((int) (System.currentTimeMillis()/1000));

        contentRepository.save(content);
        contentSummaryRepository.save(contentSummary);
    }

}
