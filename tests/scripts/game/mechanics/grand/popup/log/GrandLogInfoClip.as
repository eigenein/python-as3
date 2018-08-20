package game.mechanics.grand.popup.log
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class GrandLogInfoClip extends GuiClipNestedContainer
   {
       
      
      public var dialog_frame:GuiClipScale9Image;
      
      public var button_close:ClipButton;
      
      public var tf_attacker:ClipLabel;
      
      public var tf_defender:ClipLabel;
      
      public var battles:Vector.<GrandLogInfoBattleClip>;
      
      public var battles_layout:ClipLayout;
      
      public function GrandLogInfoClip()
      {
         battles_layout = ClipLayout.verticalMiddleCenter(12);
         super();
      }
   }
}
