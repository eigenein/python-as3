package game.view.popup.summoningcircle
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import game.mechanics.dungeon.popup.TitaniteProgressBarClip;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.refillable.CostButton;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class SummoningCirclePopUpClip extends PopupClipBase
   {
       
      
      public var cost_button_pack:CostButton;
      
      public var cost_button_single:CostButton;
      
      public var cost_button_pack10:CostButton;
      
      public var buttons_layout_group:ClipLayout;
      
      public var line_top:ClipSprite;
      
      public var line_bottom:ClipSprite;
      
      public var tf_desc:ClipLabel;
      
      public var tf_receive:ClipLabel;
      
      public var tf_open_single:ClipLabel;
      
      public var tf_open_pack:ClipLabel;
      
      public var tf_open_pack10:ClipLabel;
      
      public var labels_layout_group:ClipLayout;
      
      public var tf_timer:SpecialClipLabel;
      
      public var progress_titanite:TitaniteProgressBarClip;
      
      public var btn_navigate:ClipButtonLabeled;
      
      public var reward_item:InventoryItemRenderer;
      
      public var bg_container:ClipLayout;
      
      public var slotUltra1:ClipLayout;
      
      public var slotUltra2:ClipLayout;
      
      public var slotUltra3:ClipLayout;
      
      public var slot1:ClipLayout;
      
      public var slot2:ClipLayout;
      
      public var slot3:ClipLayout;
      
      public var slot4:ClipLayout;
      
      public var slot5:ClipLayout;
      
      public var slot6:ClipLayout;
      
      public var slot7:ClipLayout;
      
      public var slot8:ClipLayout;
      
      public var slot9:ClipLayout;
      
      public var anim_idle:GuiAnimation;
      
      public var bg_image:GuiAnimation;
      
      public function SummoningCirclePopUpClip()
      {
         cost_button_pack = new CostButton();
         cost_button_single = new CostButton();
         cost_button_pack10 = new CostButton();
         buttons_layout_group = ClipLayout.horizontalMiddleCentered(4,cost_button_single,cost_button_pack,cost_button_pack10);
         line_top = new ClipSprite();
         line_bottom = new ClipSprite();
         tf_desc = new ClipLabel();
         tf_receive = new ClipLabel();
         tf_open_single = new ClipLabel();
         tf_open_pack = new ClipLabel();
         tf_open_pack10 = new ClipLabel();
         labels_layout_group = ClipLayout.horizontalMiddleCentered(4,tf_open_single,tf_open_pack,tf_open_pack10);
         tf_timer = new SpecialClipLabel();
         progress_titanite = new TitaniteProgressBarClip();
         btn_navigate = new ClipButtonLabeled();
         reward_item = new InventoryItemRenderer();
         bg_container = ClipLayout.none();
         slotUltra1 = ClipLayout.none();
         slotUltra2 = ClipLayout.none();
         slotUltra3 = ClipLayout.none();
         slot1 = ClipLayout.none();
         slot2 = ClipLayout.none();
         slot3 = ClipLayout.none();
         slot4 = ClipLayout.none();
         slot5 = ClipLayout.none();
         slot6 = ClipLayout.none();
         slot7 = ClipLayout.none();
         slot8 = ClipLayout.none();
         slot9 = ClipLayout.none();
         anim_idle = new GuiAnimation();
         bg_image = new GuiAnimation();
         super();
      }
   }
}
