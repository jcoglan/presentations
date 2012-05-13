!SLIDE 
# JavaScript

## It's going to be okay.


!SLIDE bullets
# What?

* Highly dynamic
* Object oriented
* Functional


!SLIDE bullets
# What?

* Function model: Scheme
* Object system: Self
* Syntax: Java


!SLIDE
# Brendan Eich:

    @@@ javascript
    // 'I was recruited to Netscape with the promise
    //  of "doing Scheme" in the browser.'
    
    (define-syntax cond (syntax-rules (else =>)
      ((cond) #f)
      ((cond (else expr1 expr2 ...))
        (begin expr1 expr2 ...))
      ((cond (test => procedure) clause ...)
        (let ((temp test))
          (if temp
              (procedure temp)
              (cond clause ...))))
      ((cond (test expression ...) clause ...)
        (if test
            (begin expression ...)
            (cond clause ...)))))


!SLIDE
# Netscape:

    @@@ javascript
    public interface RequestProcessorFactoryFactory {
      RequestProcessorFactory
          getRequestProcessorFactory(java.lang.class pClass)
          throws XmlRpcException;
      
      static interface RequestProcessorFactory {
      }
      
      static class RequestSpecificProcessorFactoryFactory
          implements RequestProcessorFactoryFactory {
        
        protected java.lang.Object
            getRequestProcessor(java.lang.Class pClass,
                                XmlRpcRequest pRequest) {
        }
        
        RequestProcessorFactory
            getRequestProcessorFactory(java.lang.Class pClass)
            throws XmlRpcException {
        }
      }
    }
