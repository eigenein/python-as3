package game.mechanics.clan_war.popup.plan
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.data.storage.DataStorage;
   import game.mechanics.clan_war.mediator.ClanWarPlanScreenMediator;
   import game.mechanics.clan_war.popup.ClanWarBuildingButton;
   import game.mechanics.clan_war.storage.ClanWarFortificationDescription;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   import starling.events.Event;
   
   public class ClanWarPlanScreen extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var mediator:ClanWarPlanScreenMediator;
      
      private var clip:ClanWarPlanScreenClip;
      
      public function ClanWarPlanScreen(param1:ClanWarPlanScreenMediator)
      {
         super(param1,AssetStorage.rsx.clan_war_map);
         this.mediator = param1;
         param1.signal_warriorsUpdate.add(handler_warriorsUpdate);
         param1.signal_roleUpdate.add(handler_roleUpdate);
      }
      
      override public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = clip.plan_map.building.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            clip.plan_map.building[_loc2_].dispose();
            _loc2_++;
         }
         mediator.signal_defendersUpdate.remove(signal_defendersUpdate);
         mediator.properties_permissions.unsubscribe(handler_permissions);
         mediator.signal_warriorsUpdate.remove(handler_warriorsUpdate);
         super.dispose();
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         super.onAssetLoaded(param1);
         width = 1000;
         height = 640;
         clip = param1.create(ClanWarPlanScreenClip,"clan_warplan_view");
         addChild(clip.graphics);
         clip.button_close.signal_click.add(close);
         clip.layout_playerstatus.height = NaN;
         var _loc2_:VerticalLayout = clip.layout_playerstatus.layout as VerticalLayout;
         _loc2_.padding = 10;
         _loc2_.paddingBottom = 12;
         clip.layout_playerstatus.addEventListener("resize",handler_resizePlayerStatus);
         clip.tf_header.text = Translate.translate("UI_DEFENSE_PLAN_UI_CLIP_TF_HEADER");
         mediator.properties_permissions.onValue(handler_permissions);
         if(mediator.defendersInitialized)
         {
            initMap();
         }
         else
         {
            mediator.signal_defendersUpdate.add(signal_defendersUpdate);
         }
         clip.tf_name.text = mediator.participant_us.info.title;
         clip.clan_icon.setData(mediator.participant_us.info);
         clip.button_members.signal_click.add(mediator.action_assignChampions);
         if(mediator.nextWarIsTomorrow)
         {
            clip.tf_title.text = Translate.translate("UI_CLAN_WARPLAN_VIEW_TF_TITLE_TOMORROW");
         }
         else
         {
            clip.tf_title.text = Translate.translate("UI_CLAN_WARPLAN_VIEW_TF_HEADER");
         }
         updateWarriorsMarker();
      }
      
      private function handler_permissions(param1:Boolean, param2:Boolean) : void
      {
         if(param2)
         {
            clip.button_members.label = Translate.translate("UI_CLAN_WAR_VIEW_ASSIGN_CHAMPIONS");
         }
         else
         {
            clip.button_members.label = Translate.translate("UI_CLAN_WAR_MEMBERS_TITLE");
         }
         clip.tf_header.visible = param2 || param1;
         if(param2)
         {
            clip.tf_desc.text = Translate.translate("UI_CLAN_WAR_VIEW_DEFENCE_PLAN_LEADER");
         }
         else if(param1)
         {
            clip.tf_desc.text = Translate.translate("UI_CLAN_WAR_VIEW_DEFENCE_PLAN_WARRIOR");
         }
         else
         {
            clip.tf_desc.text = Translate.translateArgs("UI_CLAN_WAR_VIEW_DEFENCE_PLAN_MEMBER",mediator.title_leader,mediator.title_warlord);
         }
      }
      
      private function _initMap(param1:ClanWarPlanMapClip, param2:Function) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc6_:Vector.<ClanWarFortificationDescription> = DataStorage.clanWar.getFortificationList();
         param1.setClanIcon(mediator.participant_us.info.icon);
         var _loc4_:int = param1.building.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = param1.building[_loc5_];
            _loc3_.setDesc(_loc6_[_loc5_]);
            _loc3_.setData_PlanSlotVO(mediator.getSlots(_loc6_[_loc5_]));
            _loc3_.signal_click.add(param2);
            _loc5_++;
         }
      }
      
      private function initMap() : void
      {
         _initMap(clip.plan_map,mediator.action_selectPlanBuilding);
      }
      
      private function updateWarriorsMarker() : void
      {
         clip.red_dot.graphics.visible = mediator.redMarkerState_canAssignMoreChampions;
      }
      
      private function signal_defendersUpdate() : void
      {
         mediator.signal_defendersUpdate.remove(signal_defendersUpdate);
         initMap();
      }
      
      private function handler_resizePlayerStatus(param1:Event) : void
      {
         clip.bg_member_status.graphics.height = clip.layout_playerstatus.height;
      }
      
      private function handler_warriorsUpdate() : void
      {
         updateWarriorsMarker();
      }
      
      private function handler_roleUpdate() : void
      {
         updateWarriorsMarker();
      }
   }
}
