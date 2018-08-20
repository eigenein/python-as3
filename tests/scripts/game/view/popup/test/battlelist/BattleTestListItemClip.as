package game.view.popup.test.battlelist
{
   import engine.core.clipgui.ClipSprite;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   
   public class BattleTestListItemClip extends ClipButton
   {
       
      
      public const tf_label:ClipLabel = new ClipLabel();
      
      public const tf_label_selected:ClipLabel = new ClipLabel();
      
      public const icon_check:ClipSprite = new ClipSprite();
      
      public const icon_off:ClipSprite = new ClipSprite();
      
      public const icon_on:ClipSprite = new ClipSprite();
      
      public function BattleTestListItemClip()
      {
         super();
         setHover(false);
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         super.setupState(param1,param2);
         var _loc3_:Boolean = param1 == "hover" || param1 == "down";
         setHover(_loc3_);
      }
      
      public function set label(param1:String) : void
      {
         var _loc2_:* = param1;
         tf_label_selected.text = _loc2_;
         tf_label.text = _loc2_;
      }
      
      protected function setHover(param1:Boolean) : void
      {
         tf_label.graphics.visible = !param1;
         tf_label_selected.graphics.visible = param1;
      }
   }
}
