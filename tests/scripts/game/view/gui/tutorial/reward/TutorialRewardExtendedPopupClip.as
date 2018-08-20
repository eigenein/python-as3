package game.view.gui.tutorial.reward
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class TutorialRewardExtendedPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var button_ok:ClipButtonLabeled;
      
      public var tf_header:ClipLabel;
      
      public var tf_label_reward:ClipLabel;
      
      public var glow:ClipSprite;
      
      public var bg:GuiClipScale9Image;
      
      public const reward_item:ClipDataProvider = new ClipDataProvider();
      
      public const layout:ClipLayout = ClipLayout.verticalCenter(15);
      
      public function TutorialRewardExtendedPopupClip()
      {
         button_close = new ClipButton();
         button_ok = new ClipButtonLabeled();
         tf_header = new ClipLabel();
         tf_label_reward = new ClipLabel();
         glow = new ClipSprite();
         bg = new GuiClipScale9Image();
         super();
      }
   }
}
