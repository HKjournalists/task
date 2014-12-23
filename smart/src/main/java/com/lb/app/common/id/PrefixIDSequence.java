package com.lb.app.common.id;

import java.io.Serializable;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.MappingException;
import org.hibernate.cfg.ObjectNameNormalizer;
import org.hibernate.dialect.Dialect;
import org.hibernate.engine.spi.SessionImplementor;
import org.hibernate.id.Configurable;
import org.hibernate.id.PersistentIdentifierGenerator;
import org.hibernate.id.SequenceGenerator;
import org.hibernate.internal.util.config.ConfigurationHelper;
import org.hibernate.type.LongType;
import org.hibernate.type.Type;

public class PrefixIDSequence extends SequenceGenerator implements   
PersistentIdentifierGenerator, Configurable{
	
	final private static Log log = LogFactory.getLog(PrefixIDSequence.class);

	
	public static final String PREFIX = "prefix";   
    private String prefix;   
  
    @Override
	public void configure(Type type, Properties params, Dialect dialect) throws MappingException {
    	
    	type = new LongType(); 
        super.configure(type, params, dialect);  
		ObjectNameNormalizer normalizer = ( ObjectNameNormalizer ) params.get( IDENTIFIER_NORMALIZER );
        prefix = normalizer.normalizeIdentifierQuoting(
				ConfigurationHelper.getString( PREFIX, params, "ID" )
		);
    }
    
    @Override
    public Serializable generate(SessionImplementor session, Object obj) {
    	Serializable val =  super.generate(session, obj);
    	System.out.println(val);
		System.out.println( prefix + String.format("%06d", val));
		return prefix + String.format("%06d", val);
	}

    

}
