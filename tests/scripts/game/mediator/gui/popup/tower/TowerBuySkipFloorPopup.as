package game.mediator.gui.popup.tower
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.view.popup.ClipBasedPopup;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class TowerBuySkipFloorPopup extends ClipBasedPopup
   {
       
      
      private var mediator:TowerBuySkipFloorPopupMediator;
      
      public function TowerBuySkipFloorPopup(param1:TowerBuySkipFloorPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:TowerBuySkipFloorPopupClip = AssetStorage.rsx.popup_theme.create(TowerBuySkipFloorPopupClip,"popup_tower_buy_skip_floor");
         addChild(_loc1_.graphics);
         _loc1_.tf_header.text = Translate.translate("UI_TOWER_BUY_SKIP_FLOOR_HEADER");
         _loc1_.tf_desc.text = Translate.translateArgs("UI_TOWER_BUY_SKIP_FLOOR_DESC",ColorUtils.hexToRGBFormat(16645626) + "1-" + mediator.maxSkipFloor + ColorUtils.hexToRGBFormat(16639158));
         _loc1_.button_cancel.label = Translate.translate("UI_COMMON_CANCEL");
         _loc1_.button_buy.cost = mediator.skipCost.outputDisplay[0];
         _loc1_.button_close.signal_click.add(close);
         _loc1_.button_cancel.signal_click.add(close);
         _loc1_.button_buy.signal_click.add(mediator.buySkip);
      }
   }
}
