package game.mediator.gui.popup.mail
{
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class PlayerMailButtonAction
   {
       
      
      private var action:Function;
      
      private var data:Object;
      
      private var _label:String;
      
      public function PlayerMailButtonAction(param1:String, param2:Function, param3:Object)
      {
         super();
         this.data = param3;
         this.action = param2;
         this._label = param1;
      }
      
      public static function action_EUProtectionLaw(param1:PlayerMailButtonAction) : void
      {
      }
      
      public function get label() : String
      {
         return _label;
      }
      
      public function callAction() : void
      {
      }
   }
}
