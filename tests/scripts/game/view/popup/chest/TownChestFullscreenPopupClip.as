package game.view.popup.chest
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.popup.refillable.CostButton;
   
   public class TownChestFullscreenPopupClip extends PopupClipBase
   {
       
      
      public var cost_button_pack:CostButton;
      
      public var cost_button_single:CostButton;
      
      public var free_button_single:ClipButtonLabeled;
      
      public var tf_hero_drop_desc:ClipLabel;
      
      public var tf_chest_desc:ClipLabel;
      
      public var tf_chest_promt:ClipLabel;
      
      public var tf_open_single:ClipLabel;
      
      public var tf_open_pack:ClipLabel;
      
      public var drop_block:ChestDropBlockClip;
      
      public var tf_cooldown:ClipLabel;
      
      public var blind_container:GuiClipLayoutContainer;
      
      public var quest_promo:ChestQuestPromoClip;
      
      public function TownChestFullscreenPopupClip()
      {
         cost_button_pack = new CostButton();
         cost_button_single = new CostButton();
         free_button_single = new ClipButtonLabeled();
         tf_hero_drop_desc = new ClipLabel();
         tf_chest_desc = new ClipLabel();
         tf_chest_promt = new ClipLabel();
         tf_open_single = new ClipLabel();
         tf_open_pack = new ClipLabel();
         drop_block = new ChestDropBlockClip();
         tf_cooldown = new ClipLabel();
         blind_container = new GuiClipLayoutContainer();
         quest_promo = new ChestQuestPromoClip();
         super();
      }
   }
}
