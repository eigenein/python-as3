package game.mediator.gui.popup.team
{
   public class TeamGatherHeroBlockReason
   {
       
      
      private var _text:String;
      
      public function TeamGatherHeroBlockReason(param1:String)
      {
         super();
         this._text = param1;
      }
      
      public function get text() : String
      {
         return _text;
      }
   }
}
