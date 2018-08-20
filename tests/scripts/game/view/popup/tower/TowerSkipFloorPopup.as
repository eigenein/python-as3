package game.view.popup.tower
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.tower.TowerSkipFloorPopupMediator;
   import game.model.GameModel;
   import game.view.popup.ClipBasedPopup;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class TowerSkipFloorPopup extends ClipBasedPopup
   {
       
      
      private var mediator:TowerSkipFloorPopupMediator;
      
      public function TowerSkipFloorPopup(param1:TowerSkipFloorPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         var _loc1_:* = null;
         var _loc4_:* = null;
         super.initialize();
         var _loc3_:TowerSkipFloorPopupClip = AssetStorage.rsx.popup_theme.create(TowerSkipFloorPopupClip,"popup_tower_skip_floor");
         addChild(_loc3_.graphics);
         _loc3_.tf_label_points.text = Translate.translate("UI_DIALOG_TOWER_BATTLE_FLOOR_ENEMY_POINTS");
         _loc3_.tf_header.text = Translate.translate("UI_TOWER_SKIP_FLOOR_HEADER");
         _loc3_.tf_skulls.text = mediator.reward_skulls.toString();
         _loc3_.tf_points.text = mediator.reward_points.toString();
         var _loc2_:String = Translate.translateArgs("UI_TOWER_SKIP_FLOOR_BATTLE_COUNT",mediator.floor);
         if(mediator.skipBought)
         {
            _loc1_ = Translate.translateArgs("UI_TOWER_SKIP_FLOOR_DESC2",Translate.genderTriggerString(GameModel.instance.player.male),"1-" + mediator.maxSkipFloor);
            _loc1_ = _loc1_.replace(/\{normal_color\}/g,ColorUtils.hexToRGBFormat(16639158));
            _loc1_ = _loc1_.replace(/\{number_color\}/g,ColorUtils.hexToRGBFormat(16645626));
            _loc3_.tf_desc.text = _loc1_;
         }
         else
         {
            _loc4_ = Translate.translateArgs("UI_TOWER_SKIP_FLOOR_DESC",Translate.genderTriggerString(GameModel.instance.player.male),_loc2_,"1-" + mediator.floor);
            _loc4_ = _loc4_.replace(/\{normal_color\}/g,ColorUtils.hexToRGBFormat(16639158));
            _loc4_ = _loc4_.replace(/\{number_color\}/g,ColorUtils.hexToRGBFormat(16645626));
            _loc3_.tf_desc.text = _loc4_;
         }
         _loc3_.btn_fight.label = Translate.translate("UI_TOWER_SKIP_FLOOR_BTN_FIGHT");
         _loc3_.btn_skip.label = Translate.translate("UI_TOWER_SKIP_FLOOR_BTN_SKIP");
         _loc3_.button_close.signal_click.add(close);
         _loc3_.btn_fight.signal_click.add(mediator.action_fight);
         _loc3_.btn_skip.signal_click.add(mediator.action_skip);
      }
   }
}
