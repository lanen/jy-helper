package com.buyou.agent;

import java.lang.instrument.Instrumentation;

/**
 * @author evan
 * @date 2019-03-20
 */
public class PreMain {

    public static void premain(String agentOps, Instrumentation inst) {

        System.out.println(agentOps);
        System.out.println("FFFFFFFFFFFFFFFFFF sldfjslfj sdlfjsdlfjsldjflsdlf sljfdl");

    }
}
