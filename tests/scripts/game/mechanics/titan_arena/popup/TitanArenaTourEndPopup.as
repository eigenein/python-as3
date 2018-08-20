package game.mechanics.titan_arena.popup
{
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.titan_arena.mediator.TitanArenaTourEndPopupMediator;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class TitanArenaTourEndPopup extends ClipBasedPopup
   {
       
      
      private var mediator:TitanArenaTourEndPopupMediator;
      
      public function TitanArenaTourEndPopup(param1:TitanArenaTourEndPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         var _loc1_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:* = null;
         super.initialize();
         var _loc5_:RsxGuiAsset = AssetStorage.rsx.getByName(TitanArenaPopup.ASSET_IDENT) as RsxGuiAsset;
         var _loc6_:TitanArenaDefenseWarningPopupClip = _loc5_.create(TitanArenaDefenseWarningPopupClip,"dialog_defense_warning");
         addChild(_loc6_.graphics);
         var _loc2_:ClipLayout = ClipLayout.horizontalMiddleCentered(4);
         _loc6_.layout_text.addChild(_loc2_);
         if(mediator.reward)
         {
            _loc1_ = mediator.reward.outputDisplay;
            _loc6_.layout_text.removeChild(_loc6_.button_ok.graphics);
            _loc3_ = _loc1_.length;
            _loc4_ = 0;
            while(_loc4_ < 1)
            {
               _loc7_ = AssetStorage.rsx.popup_theme.create(InventoryItemRenderer,"inventory_tile");
               _loc7_.setData(_loc1_[_loc4_]);
               _loc2_.addChild(_loc7_.container);
               _loc4_++;
            }
            _loc6_.layout_text.addChild(_loc6_.button_ok.graphics);
         }
         _loc6_.tf_header.text = mediator.header;
         _loc6_.button_ok.label = mediator.button;
         _loc6_.layout_text.height = NaN;
         _loc6_.tf_message.height = NaN;
         _loc6_.tf_message.text = mediator.message;
         _loc6_.layout_text.validate();
         _loc6_.bg.graphics.height = _loc6_.layout_text.graphics.y + _loc6_.layout_text.graphics.height + 4;
         _loc6_.button_close.signal_click.add(mediator.close);
         _loc6_.button_ok.signal_click.add(mediator.action_ok);
      }
   }
}
