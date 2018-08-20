package game.view.specialoffer.lootboxwithdelay
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.SpecialClipLabel;
   
   public class SpecialOfferLootBoxWithDelayPopupClip extends GuiClipNestedContainer
   {
       
      
      public var tf_header:ClipLabel;
      
      public var tf_description:ClipLabel;
      
      public var tf_timer:SpecialClipLabel;
      
      public var button_continue:ClipButtonLabeled;
      
      public var button_open:ClipButtonLabeled;
      
      public var line2:ClipSprite;
      
      public var animation_closed:GuiAnimation;
      
      public var animation_opened:GuiAnimation;
      
      public function SpecialOfferLootBoxWithDelayPopupClip()
      {
         tf_header = new ClipLabel();
         tf_description = new ClipLabel();
         tf_timer = new SpecialClipLabel();
         button_continue = new ClipButtonLabeled();
         button_open = new ClipButtonLabeled();
         line2 = new ClipSprite();
         animation_closed = new GuiAnimation();
         animation_opened = new GuiAnimation();
         super();
      }
   }
}
