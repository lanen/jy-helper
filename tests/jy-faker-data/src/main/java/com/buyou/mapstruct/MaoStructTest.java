package com.buyou.mapstruct;

import com.buyou.article.controller.ContentSummaryMapper;
import com.buyou.article.model.Content;
import com.buyou.article.model.ContentDto;
import com.buyou.article.model.ContentType;
import com.buyou.id.SnowflakeIdGenerator;
import io.codearte.jfairy.Fairy;

/**
 * @author evan
 * @date 2019-01-31
 */
public class MaoStructTest {
    public static void main(String[] args) {
        SnowflakeIdGenerator generator = new SnowflakeIdGenerator(0,0);
        Fairy fairy = Fairy.create();

        Long contentId = generator.nextId();
        Long authorId = generator.nextId();

        Content content = new Content();
        content.setContentId(contentId);
        content.setAuthorId(authorId);
        content.setContentType(ContentType.MARKDOWN);

        content.setContent(fairy.textProducer().sentence());

        long s = System.nanoTime();
        for (int i = 0;i < 1;i ++){
            ContentDto dto = ContentSummaryMapper.INSTANCE.content(content);
        }
        long e = System.nanoTime() - s;
        System.out.printf("%d\n%f s\n", e,e/1000000000.0);


         s = System.nanoTime();
        for (int i = 0;i < 1000000000;i ++){
            ContentDto dto = ContentSummaryMapper.INSTANCE.content(content);
        }
         e = System.nanoTime() - s;
        System.out.printf("%d\n%f s\n", e,e/1000000000.0);
    }
}
