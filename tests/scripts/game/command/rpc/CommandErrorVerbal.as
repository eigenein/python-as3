package game.command.rpc
{
   import com.progrestar.common.lang.Translate;
   import game.command.timer.GameTimer;
   
   public class CommandErrorVerbal
   {
       
      
      public function CommandErrorVerbal()
      {
         super();
      }
      
      public static function getText(param1:RPCCommandBase) : String
      {
         if(param1.error == null)
         {
            return "Error not identified";
         }
         var _loc2_:* = param1.error.name;
         if("common\\rpc\\exception\\InvalidSession" !== _loc2_)
         {
            if("Invalid signature" !== _loc2_)
            {
               if("invalid_signature" !== _loc2_)
               {
                  return param1.type + ":" + param1.error.message;
               }
               return param1.type + ":" + param1.error.description;
            }
            return Translate.translate("UI_POPUP_ERROR_INVALID_SESSION_TEXT_1");
         }
         if(GameTimer.instance.serverTime.time - GameTimer.instance.loginTime >= 14400)
         {
            return Translate.translate("UI_POPUP_ERROR_INVALID_SESSION_TEXT_1");
         }
         return Translate.translate("UI_POPUP_ERROR_INVALID_SESSION_TEXT_2");
      }
   }
}
