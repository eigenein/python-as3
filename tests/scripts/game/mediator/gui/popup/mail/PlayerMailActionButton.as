package game.mediator.gui.popup.mail
{
   import game.view.gui.components.DataClipButton;
   import game.view.gui.components.SpecialClipLabel;
   
   public class PlayerMailActionButton extends DataClipButton
   {
       
      
      public var guiClipLabel:SpecialClipLabel;
      
      private var _data:PlayerMailButtonAction;
      
      public function PlayerMailActionButton()
      {
         super(PlayerMailButtonAction);
      }
      
      public function get label() : String
      {
         return guiClipLabel.text;
      }
      
      public function set label(param1:String) : void
      {
         guiClipLabel.text = param1;
      }
      
      public function get data() : PlayerMailButtonAction
      {
         return _data;
      }
      
      public function set data(param1:PlayerMailButtonAction) : void
      {
         _data = param1;
         label = _data.label;
      }
      
      override public function click() : void
      {
         if(data)
         {
            data.callAction();
            super.click();
         }
      }
      
      override protected function getClickData() : *
      {
         return _data;
      }
   }
}
