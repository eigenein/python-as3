package game.mechanics.boss.popup
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiMarker;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.refillable.CostButton;
   
   public class BossChestPopupClip extends GuiClipNestedContainer
   {
       
      
      public var tf_header:ClipLabel;
      
      public var button_close:ClipButton;
      
      public var button_text:ClipButtonLabeled;
      
      public var tf_open_single:ClipLabel;
      
      public var tf_open_pack:ClipLabel;
      
      public var labels_layout_group:ClipLayout;
      
      public var button_cost:CostButton;
      
      public var button_cost_pack:CostButton;
      
      public var buttons_layout_group:ClipLayout;
      
      public var bonus_clip:BossChestPopupBonusClip;
      
      public var chestClip:ClipDataProvider;
      
      public var chest:Vector.<GuiMarker>;
      
      public var chest_left:Vector.<GuiMarker>;
      
      public var cloud:Vector.<ClipSprite>;
      
      public var tf_footer:ClipLabel;
      
      public var layout_footer:ClipLayout;
      
      public var layout_header:ClipLayout;
      
      public var chest_content:BossChestContentClip;
      
      public function BossChestPopupClip()
      {
         tf_header = new ClipLabel();
         tf_open_single = new ClipLabel();
         tf_open_pack = new ClipLabel();
         labels_layout_group = ClipLayout.horizontalMiddleCentered(4,tf_open_single,tf_open_pack);
         button_cost = new CostButton();
         button_cost_pack = new CostButton();
         buttons_layout_group = ClipLayout.horizontalMiddleCentered(4,button_cost,button_cost_pack);
         bonus_clip = new BossChestPopupBonusClip();
         chest = new Vector.<GuiMarker>();
         chest_left = new Vector.<GuiMarker>();
         cloud = new Vector.<ClipSprite>();
         tf_footer = new ClipLabel();
         layout_footer = ClipLayout.horizontalMiddleCentered(4,tf_footer);
         layout_header = ClipLayout.horizontalMiddleCentered(4,tf_header);
         chest_content = new BossChestContentClip();
         super();
      }
   }
}
