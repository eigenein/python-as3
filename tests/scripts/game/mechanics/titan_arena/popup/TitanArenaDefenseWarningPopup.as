package game.mechanics.titan_arena.popup
{
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.titan_arena.mediator.TitanArenaDefenseWarningPopupMediator;
   import game.view.popup.ClipBasedPopup;
   
   public class TitanArenaDefenseWarningPopup extends ClipBasedPopup
   {
       
      
      private var mediator:TitanArenaDefenseWarningPopupMediator;
      
      public function TitanArenaDefenseWarningPopup(param1:TitanArenaDefenseWarningPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:RsxGuiAsset = AssetStorage.rsx.getByName(TitanArenaPopup.ASSET_IDENT) as RsxGuiAsset;
         var _loc2_:TitanArenaDefenseWarningPopupClip = _loc1_.create(TitanArenaDefenseWarningPopupClip,"dialog_defense_warning");
         addChild(_loc2_.graphics);
         _loc2_.tf_header.text = mediator.header;
         _loc2_.button_ok.label = mediator.button;
         _loc2_.layout_text.height = NaN;
         _loc2_.tf_message.height = NaN;
         _loc2_.tf_message.text = mediator.message;
         _loc2_.layout_text.validate();
         _loc2_.bg.graphics.height = _loc2_.layout_text.graphics.y + _loc2_.layout_text.graphics.height + 4;
         _loc2_.button_close.signal_click.add(mediator.close);
         _loc2_.button_ok.signal_click.add(mediator.action_ok);
      }
   }
}
