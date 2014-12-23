package com.asiainfo.lucene.test;

import java.io.StringReader;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.tokenattributes.CharTermAttribute;
import org.wltea.analyzer.lucene.IKAnalyzer;

public class IKAnalyzerTest {
	public static void main(String[] args) {
		String keyWord = "IKAnalyzer�ķִ�Ч��������ô���أ����������й�����Ҷ������һ�°�";
		//����IKAnalyzer���ķִʶ���
		IKAnalyzer analyzer = new IKAnalyzer(false);
		// ʹ�����ִܷ�
		analyzer.setUseSmart(false);
		// ��ӡ�ִʽ��
		try {
			printAnalysisResult(analyzer, keyWord);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * ��ӡ�������ִ����ķִʽ��
	 * 
	 * @param analyzer
	 *            �ִ���
	 * @param keyWord
	 *            �ؼ���
	 * @throws Exception
	 */
	private static void printAnalysisResult(Analyzer analyzer, String keyWord)
			throws Exception {
		System.out.println("["+keyWord+"]�ִ�Ч������");
		TokenStream tokenStream = analyzer.tokenStream("content",new StringReader(keyWord));
		tokenStream.addAttribute(CharTermAttribute.class);
		while (tokenStream.incrementToken()) {
			CharTermAttribute charTermAttribute = tokenStream.getAttribute(CharTermAttribute.class);
			System.out.print("|"+charTermAttribute.toString());

		}
	}
}
