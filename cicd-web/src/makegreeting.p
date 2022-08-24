
/*------------------------------------------------------------------------
    File        : makegreeting.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : cthomson
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

block-level on error undo, throw.

using OpenEdge.Core.Assert from propath.

define input  parameter pcHelloName  as character no-undo.
define output parameter pcOutMessage as character no-undo.

define variable Logger as OpenEdge.Logging.ILogWriter no-undo.

/* ***************************  Main Block  *************************** */

assign
    Logger = OpenEdge.Logging.LoggerBuilder:GetLogger('makegreeting').
   
mainblock:
do on error undo, throw:
    Logger:Info('Starting').

    Assert:NotNullOrEmpty(pcHelloName, 'HelloName').
    
    assign
        pcOutMessage = substitute('Hello &1',pcHelloName).
            
    catch er as Progress.Lang.Error :
        /* catch, log, and rethrow */
        Logger:Error('Error',er).
        
        undo, throw er.            
    end catch.
end. /* mainblock */

finally:
    Logger:info('Done').
end finally.
/* EOF */