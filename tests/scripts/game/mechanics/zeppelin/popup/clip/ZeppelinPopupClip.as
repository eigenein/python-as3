package game.mechanics.zeppelin.popup.clip
{
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipHitTestImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipLayout;
   
   public class ZeppelinPopupClip extends PopupClipBase
   {
       
      
      public var clouds_left:GuiAnimation;
      
      public var clouds_right:GuiAnimation;
      
      public var clouds_sky:GuiAnimation;
      
      public var clouds_tunnel:GuiAnimation;
      
      public var btn_characters:ZeppelinPopupCharactersButton;
      
      public var btn_chest:ZeppelinPopupChestButton;
      
      public var btn_dealer:ZeppelinPopupDealerButton;
      
      public var btn_desk:ZeppelinPopupDeskButton;
      
      public var btn_subscription:ZeppelinPopupSubscriptionButton;
      
      public var bg_anim:GuiClipNestedContainer;
      
      public var layout_special_offer:ClipLayout;
      
      public var sofa_bitmap:ClipSpriteUntouchable;
      
      public var sofa_hitTest:GuiClipHitTestImage;
      
      public function ZeppelinPopupClip()
      {
         clouds_left = new GuiAnimation();
         clouds_right = new GuiAnimation();
         clouds_sky = new GuiAnimation();
         clouds_tunnel = new GuiAnimation();
         btn_characters = new ZeppelinPopupCharactersButton();
         btn_chest = new ZeppelinPopupChestButton();
         btn_dealer = new ZeppelinPopupDealerButton();
         btn_desk = new ZeppelinPopupDeskButton();
         btn_subscription = new ZeppelinPopupSubscriptionButton();
         bg_anim = new GuiClipNestedContainer();
         layout_special_offer = ClipLayout.none();
         sofa_bitmap = new ClipSpriteUntouchable();
         sofa_hitTest = new GuiClipHitTestImage();
         super();
      }
      
      public function dispose() : void
      {
         btn_characters.dispose();
      }
   }
}
