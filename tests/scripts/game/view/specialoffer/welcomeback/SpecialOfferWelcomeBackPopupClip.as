package game.view.specialoffer.welcomeback
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipContainer;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.friends.socialquest.RewardItemClip;
   
   public class SpecialOfferWelcomeBackPopupClip extends PopupClipBase
   {
       
      
      public var button_buy:ClipButtonLabeled;
      
      public var tf_description:SpecialClipLabel;
      
      public var tf_header:ClipLabel;
      
      public var plus:Vector.<ClipSprite>;
      
      public var reward:Vector.<RewardItemClip>;
      
      public var animation:Vector.<GuiAnimation>;
      
      public var animation_highlight:GuiAnimation;
      
      public var marker_bg:GuiClipContainer;
      
      public function SpecialOfferWelcomeBackPopupClip()
      {
         button_buy = new ClipButtonLabeled();
         tf_description = new SpecialClipLabel();
         tf_header = new ClipLabel();
         plus = new Vector.<ClipSprite>();
         reward = new Vector.<RewardItemClip>();
         animation = new Vector.<GuiAnimation>();
         animation_highlight = new GuiAnimation();
         marker_bg = new GuiClipContainer();
         super();
      }
   }
}
