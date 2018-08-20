package game.view.popup.billing.promo
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   
   public class RaidPromoExtendedPopupClip extends PopupClipBase
   {
       
      
      public var tf_best_value:ClipLabel;
      
      public var tf_header:ClipLabel;
      
      public var tf_label_desc:SpecialClipLabel;
      
      public var tf_raid:ClipLabel;
      
      public var tf_unlock_raids:ClipLabel;
      
      public var SuperPlus_inst0:ClipSprite;
      
      public var action_btn:ClipButtonLabeled;
      
      public var drape1:ClipSprite;
      
      public var drape2:ClipSprite;
      
      public var drape3:ClipSprite;
      
      public var drape4:ClipSprite;
      
      public var marker_bg:ClipSprite;
      
      public var purple_arrow_inst0:ClipSprite;
      
      public var raid_bg_inst0:ClipSprite;
      
      public var unlock_raids_icon_inst0:ClipSprite;
      
      public var vendor_girl_inst0:ClipSprite;
      
      public var header_heroic_178_178_2_inst0:GuiClipScale3Image;
      
      public var layout_group:ClipLayout;
      
      public function RaidPromoExtendedPopupClip()
      {
         tf_best_value = new ClipLabel();
         tf_header = new ClipLabel();
         tf_label_desc = new SpecialClipLabel();
         tf_raid = new ClipLabel();
         tf_unlock_raids = new ClipLabel();
         SuperPlus_inst0 = new ClipSprite();
         action_btn = new ClipButtonLabeled();
         drape1 = new ClipSprite();
         drape2 = new ClipSprite();
         drape3 = new ClipSprite();
         drape4 = new ClipSprite();
         marker_bg = new ClipSprite();
         purple_arrow_inst0 = new ClipSprite();
         raid_bg_inst0 = new ClipSprite();
         unlock_raids_icon_inst0 = new ClipSprite();
         vendor_girl_inst0 = new ClipSprite();
         header_heroic_178_178_2_inst0 = new GuiClipScale3Image(178,2);
         layout_group = ClipLayout.horizontalMiddleCentered(5);
         super();
      }
   }
}
