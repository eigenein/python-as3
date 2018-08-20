package game.mechanics.titan_arena.popup
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mechanics.zeppelin.popup.clip.ZeppelinPopupButton;
   import game.mechanics.zeppelin.popup.clip.ZeppelinPopupDealerButton;
   import game.view.gui.components.ClipButton;
   
   public class TitanValleyPopupClip extends GuiClipNestedContainer
   {
       
      
      public var btn_altar:ZeppelinPopupButton;
      
      public var btn_arena:ZeppelinPopupButton;
      
      public var btn_hall_of_fame:ZeppelinPopupButton;
      
      public var btn_merchant:ZeppelinPopupDealerButton;
      
      public var btn_temple:TitanValleyPopupTempleButton;
      
      public var button_fire:TitanValleyPopupSpiritButton;
      
      public var button_earth:TitanValleyPopupSpiritButton;
      
      public var button_water:TitanValleyPopupSpiritButton;
      
      public var button_close:ClipButton;
      
      public var ground_animation_1:GuiAnimation;
      
      public var clouds_animation_2:GuiAnimation;
      
      public var clouds_animation_3:GuiAnimation;
      
      public var clouds_animation_4:GuiAnimation;
      
      public var boat_1_animation:GuiAnimation;
      
      public function TitanValleyPopupClip()
      {
         btn_altar = new ZeppelinPopupButton();
         btn_arena = new ZeppelinPopupButton();
         btn_hall_of_fame = new ZeppelinPopupButton();
         btn_merchant = new ZeppelinPopupDealerButton();
         btn_temple = new TitanValleyPopupTempleButton();
         button_fire = new TitanValleyPopupSpiritButton();
         button_earth = new TitanValleyPopupSpiritButton();
         button_water = new TitanValleyPopupSpiritButton();
         button_close = new ClipButton();
         ground_animation_1 = new GuiAnimation();
         clouds_animation_2 = new GuiAnimation();
         clouds_animation_3 = new GuiAnimation();
         clouds_animation_4 = new GuiAnimation();
         boat_1_animation = new GuiAnimation();
         super();
      }
   }
}
