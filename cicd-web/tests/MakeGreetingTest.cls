 
/*------------------------------------------------------------------------
   File        : MakeGreeting
   Purpose     : 
   Syntax      : 
   Description : 
   Author(s)   : cthomson
   Created     : 
   Notes       : 
       @Ignore - ignored method -- will not be tested/executed
       
 ----------------------------------------------------------------------*/

block-level on error undo, throw.

using OpenEdge.Core.Assert from propath.

class MakeGreetingTest:
    
    define public property Logger as OpenEdge.Logging.ILogWriter
        get:  
            if not valid-object(Logger) then
                assign Logger = OpenEdge.Logging.LoggerBuilder:GetLogger('test.makegreeting').
            return Logger.
        end.
        set.
    
    define public property GreetTemplate as character no-undo
        init 'Hello &1'
        get.
        set.
              
    /*------------------------------------------------------------------------------
             Purpose:  Executed BEFORE running ANY @test methods                                                                        
             Notes:    will see this exected ONCE per Test class                                                                     
     ------------------------------------------------------------------------------*/
    @Before.
    method public void setUpBeforeClass(  ):
        Logger:Debug(substitute('Running BEFORE')).
        
        return.
    end method.
    
    /*------------------------------------------------------------------------------
            Purpose:   Executed prior to EACH @test method                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @Setup.
    method public void setUp(  ):
        Logger:Debug(substitute('Running SETUP')).
        
        return.
    end method.
    
    /*------------------------------------------------------------------------------
     Purpose: Test when ToWhom is unset or set blank/null.
     Notes:
         @Test (expected="ExceptionType") -- expecting errors
    ------------------------------------------------------------------------------*/
    @Test (expected='Progress.Lang.Error').
    method public void HelloIsBlankError(  ):  
        define variable ToWhom    as character no-undo init ''.
        define variable cHelloMsg as character no-undo.
        
        Logger:Debug(substitute('Calling HelloIsBlankError')).
        
        run makegreeting.p
            ( input  ToWhom,
              output cHelloMsg
            ).
        
        /* expected result: "Hello <blank>" - actually ERROR */
        assign
            ToWhom = subst(GreetTemplate,ToWhom).
            
        Assert:Equals(cHelloMsg, ToWhom).
                    
        return.
    end method. /* HelloIsBlankError */
    
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @Test.
    method public void HelloToMe(  ):  
        define variable ToWhom    as character no-undo init 'Me'.
        define variable cHelloMsg as character no-undo.
        
        Logger:Debug(substitute('Calling HelloToMe')).
        
        run makegreeting.p
            ( input  ToWhom,
              output cHelloMsg
            ).
        
        /* expected result: "Hello Me" */
        assign
            ToWhom = subst(GreetTemplate,ToWhom).
            
        Assert:Equals(cHelloMsg, ToWhom).
                    
        return.
    end method. /* HelloToMe */
    
    /*------------------------------------------------------------------------------
            Purpose: Executed after EACH @test method                                                                         
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @TearDown.
    method public void tearDown(  ):
        Logger:Debug(substitute('Running TEARDOWN')).
        
        return.
    end method.
     
    /*------------------------------------------------------------------------------
            Purpose:  Executed after completion of ALL @test methods                                                                      
            Notes:    will see this executed ONCE per Test class                                                                    
    ------------------------------------------------------------------------------*/
    @After.
    method public void tearDownAfterClass(  ):
        Logger:Debug(substitute('Running AFTER')).

        return.
    end method.
     
end class.