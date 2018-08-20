package game.mechanics.zeppelin.popup.clip
{
   import game.view.gui.components.ClipLabel;
   import game.view.gui.homescreen.HomeScreenBuildingButton;
   
   public class ZeppelinPopupButton extends HomeScreenBuildingButton
   {
       
      
      public var tf_label:ClipLabel;
      
      public function ZeppelinPopupButton()
      {
         tf_label = new ClipLabel();
         super();
      }
      
      override public function set label(param1:String) : void
      {
         if(_label == param1)
         {
            return;
         }
         _label = param1;
         tf_label.text = param1;
      }
   }
}
