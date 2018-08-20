package game.mechanics.clan_war.popup.plan.building
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mechanics.clan_war.model.ClanWarPlanSlotValueObject;
   import game.view.gui.components.list.ListItemRenderer;
   
   public class ClanWarDefenderRenderer extends ListItemRenderer
   {
       
      
      private var clip:ClanWarDefenderRendererClip;
      
      public function ClanWarDefenderRenderer()
      {
         super();
      }
      
      override public function dispose() : void
      {
         data = null;
         super.dispose();
      }
      
      public function get slotData() : ClanWarPlanSlotValueObject
      {
         return _data as ClanWarPlanSlotValueObject;
      }
      
      override public function set data(param1:Object) : void
      {
         if(slotData)
         {
            slotData.signal_updateState.remove(handler_slotUpdate);
            slotData.signal_updatedTeam.remove(handler_teamUpdate);
         }
         .super.data = param1;
         if(slotData)
         {
            slotData.signal_updateState.add(handler_slotUpdate);
            slotData.signal_updatedTeam.add(handler_teamUpdate);
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.clan_war_map.create(ClanWarDefenderRendererClip,"defender_team_renderer");
         addChild(clip.graphics);
         clip.button_setup.signal_click.add(handler_select);
         clip.button_remove.signal_click.add(handler_remove);
         clip.tf_name.maxWidth = 200;
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         if(!slotData)
         {
            return;
         }
         if(slotData.playerIsAdmin)
         {
            clip.button_setup.label = Translate.translate("UI_DEFENDER_TEAM_RENDERER_ASSIGN");
         }
         else
         {
            clip.button_setup.label = Translate.translate("UI_DEFENDER_TEAM_RENDERER_DEFEND");
         }
         updateStateRelatedData();
      }
      
      private function updateStateRelatedData() : void
      {
         clip.button_remove.graphics.visible = slotData.canRemoveUser;
         clip.layout_no_team.visible = slotData.defender == null;
         var _loc1_:* = slotData.defender != null;
         clip.team.graphics.visible = _loc1_;
         _loc1_ = _loc1_;
         clip.player_portrait.graphics.visible = _loc1_;
         clip.layout_name.graphics.visible = _loc1_;
         if(slotData.defender)
         {
            clip.player_portrait.setData(slotData.defender.user);
            clip.team.setUnitTeam(slotData.defender.team);
            clip.tf_name.text = slotData.defender.user.nickname;
            clip.tf_power.text = slotData.teamPower.toString();
         }
         if(!slotData.defender)
         {
            if(slotData.desc.isHeroSlot)
            {
               clip.tf_warning.text = Translate.translate("UI_DEFENDER_TEAM_RENDERER_HERO_SLOT_EMPTY");
            }
            else
            {
               clip.tf_warning.text = Translate.translate("UI_DEFENDER_TEAM_RENDERER_TITAN_SLOT_EMPTY");
            }
         }
         clip.tf_warning_not_warrior.text = Translate.translate("UI_DEFENDER_TEAM_RENDERER_TF_WARNING_NOT_WARRIOR");
         clip.tf_warning_not_warrior.visible = !slotData.canSetupUser;
         clip.button_setup.graphics.visible = slotData.canSetupUser;
      }
      
      private function handler_slotUpdate() : void
      {
         updateStateRelatedData();
      }
      
      private function handler_select() : void
      {
         dispatchDataEvent("ListItemRenderer.EVENT_SELECT");
      }
      
      private function handler_remove() : void
      {
         dispatchDataEvent("ListItemRenderer.EVENT_REMOVE");
      }
      
      private function handler_teamUpdate(param1:ClanWarPlanSlotValueObject) : void
      {
         clip.team.setUnitTeam(slotData.defender.team);
      }
   }
}
