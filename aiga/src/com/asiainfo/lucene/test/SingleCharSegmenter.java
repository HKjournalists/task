package com.asiainfo.lucene.test;

import java.io.IOException;
import java.io.StringReader;

import org.wltea.analyzer.core.IKSegmenter;
import org.wltea.analyzer.core.Lexeme;
public class SingleCharSegmenter {
	
	public static void main(String[] args){  
	    IKSegmenter seg = new IKSegmenter(new StringReader("Ϊ�й�����칫��"), true);  
	    try {  
	        Lexeme lex = seg.next();  
	        while(lex != null){  
	            System.out.print(lex.getLexemeText()+"|");  
	            lex = seg.next();  
	        }  
	    } catch (IOException e) {  
	        e.printStackTrace();  
	    }  
	}
}
