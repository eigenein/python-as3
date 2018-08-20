package game.mechanics.clan_war.popup.war
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.command.rpc.clan.value.ClanIconValueObject;
   import game.data.storage.DataStorage;
   import game.mechanics.clan_war.mediator.ClanWarScreenMediator;
   import game.mechanics.clan_war.popup.ClanWarBuildingButton;
   import game.mechanics.clan_war.storage.ClanWarFortificationDescription;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   
   public class ClanWarScreen extends AsyncClipBasedPopupWithPreloader
   {
      
      public static const WIDTH:int = 1000;
      
      public static const HEIGHT:int = 640;
      
      public static const ASSET_IDENT:String = "clan_war_map";
      
      public static const SCREENSTATE_ATTACK:String = "attack";
      
      public static const SCREENSTATE_DEFEND:String = "defend";
       
      
      private var clip:ClanWarScreenClip;
      
      private var mediator:ClanWarScreenMediator;
      
      public function ClanWarScreen(param1:ClanWarScreenMediator)
      {
         super(param1,AssetStorage.rsx.getGuiByName("clan_war_map"));
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         mediator.participant_them.property_points.signal_update.remove(handler_updatePoints);
         mediator.participant_us.property_points.signal_update.remove(handler_updatePoints);
         super.dispose();
      }
      
      public function setState(param1:String) : void
      {
         var _loc2_:* = param1;
         if("attack" !== _loc2_)
         {
            if("defend" === _loc2_)
            {
               clip.maps.graphics.x = 100;
               clip.maps.graphics.y = 0;
               clip.attack_ui.graphics.visible = false;
               clip.defense_ui.graphics.visible = true;
            }
         }
         else
         {
            clip.maps.graphics.x = -800;
            clip.maps.graphics.y = 0;
            clip.attack_ui.graphics.visible = true;
            clip.defense_ui.graphics.visible = false;
         }
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         super.onAssetLoaded(param1);
         width = 1000;
         height = 640;
         clip = param1.create(ClanWarScreenClip,"clan_war_view");
         addChild(clip.graphics);
         clip.attack_ui.button_defend.label = Translate.translate("UI_CLAN_WAR_VIEW_LABEL_DEFEND");
         clip.defense_ui.button_attack.label = Translate.translate("UI_CLAN_WAR_VIEW_LABEL_ATTACK");
         clip.attack_ui.tf_header.text = Translate.translate("UI_ATTACK_UI_CLIP_TF_HEADER");
         clip.defense_ui.button_attack.signal_click.add(handler_setState_attack);
         clip.attack_ui.button_defend.signal_click.add(handler_setState_defend);
         clip.vs_header.attacker_info.setData(mediator.participant_them);
         clip.vs_header.defender_info.setData(mediator.participant_us);
         mediator.participant_them.property_points.signal_update.add(handler_updatePoints);
         mediator.participant_us.property_points.signal_update.add(handler_updatePoints);
         clip.vs_header.attacker_info.button_list.signal_click.add(mediator.action_openMemberList_enemy);
         clip.vs_header.defender_info.button_list.signal_click.add(mediator.action_openMemberList_our);
         clip.button_close.signal_click.add(close);
         _initMap(clip.maps.enemy_map,mediator.action_selectEnemyBuilding,false);
         _initMap(clip.maps.my_map,mediator.action_selectMyBuilding,true);
         setState("attack");
      }
      
      private function _initMap(param1:ClanWarMapClip, param2:Function, param3:Boolean) : void
      {
         var _loc7_:int = 0;
         var _loc4_:* = null;
         var _loc8_:Vector.<ClanWarFortificationDescription> = DataStorage.clanWar.getFortificationList();
         var _loc5_:ClanIconValueObject = !!param3?mediator.participant_us.info.icon:mediator.participant_them.info.icon;
         param1.setClanIcon(_loc5_);
         var _loc6_:int = param1.building.length;
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc4_ = param1.building[_loc7_];
            _loc4_.setDesc(_loc8_[_loc7_]);
            _loc4_.signal_click.add(param2);
            if(param3)
            {
               _loc4_.setData_WarSlotVO(mediator.getOurSlots(_loc8_[_loc7_]));
            }
            else
            {
               _loc4_.setData_WarSlotVO(mediator.getEnemySlots(_loc8_[_loc7_]));
            }
            _loc7_++;
         }
      }
      
      private function handler_updatePoints(param1:int) : void
      {
         clip.vs_header.attacker_info.tf_points.text = mediator.participant_them.pointsEarned.toString();
         clip.vs_header.defender_info.tf_points.text = mediator.participant_us.pointsEarned.toString();
      }
      
      private function handler_setState_attack() : void
      {
         setState("attack");
      }
      
      private function handler_setState_defend() : void
      {
         setState("defend");
      }
   }
}
