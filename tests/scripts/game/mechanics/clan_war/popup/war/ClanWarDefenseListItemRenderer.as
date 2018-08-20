package game.mechanics.clan_war.popup.war
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mechanics.clan_war.mediator.ClanWarSlotState;
   import game.mechanics.clan_war.model.ClanWarSlotValueObject;
   import game.view.gui.components.list.ListItemRenderer;
   
   public class ClanWarDefenseListItemRenderer extends ListItemRenderer
   {
       
      
      private var clip:ClanWarDefenseListItemRendererClip;
      
      public function ClanWarDefenseListItemRenderer()
      {
         super();
      }
      
      public function get slotData() : ClanWarSlotValueObject
      {
         return _data as ClanWarSlotValueObject;
      }
      
      override public function set data(param1:Object) : void
      {
         if(slotData)
         {
            slotData.property_clanWarSlotState.signal_update.remove(handler_slotStateChange);
         }
         .super.data = param1;
         if(slotData)
         {
            slotData.property_clanWarSlotState.signal_update.add(handler_slotStateChange);
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.clan_war_map.create(ClanWarDefenseListItemRendererClip,"defender_team_renderer_war");
         addChild(clip.graphics);
         clip.tf_name.maxWidth = 200;
         clip.tf_label_free.height = NaN;
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         if(!slotData)
         {
            return;
         }
         handler_slotStateChange(null);
         if(slotData.team)
         {
            clip.player_portrait.setData(slotData.defender.user);
            clip.team.setUnitTeam(slotData.team,slotData.defender.hpPercentState);
            clip.tf_power.text = slotData.teamPower.toString();
            clip.tf_name.text = !!slotData.defender.user?slotData.defender.user.nickname:"";
         }
      }
      
      private function update() : void
      {
         var _loc1_:Boolean = false;
         clip.layout_none.graphics.visible = slotData.team != null;
         clip.layout_free.graphics.visible = slotData.team == null;
         clip.layout_points.visible = slotData.pointsFarmed > 0;
         clip.tf_points.text = slotData.pointsFarmed.toString();
         if(slotData.team)
         {
            clip.layout_points.y = 21;
            _loc1_ = !slotData.property_isTierAvailable.value || slotData.team && (slotData.slotState == ClanWarSlotState.IN_BATTLE || slotData.slotState == ClanWarSlotState.DEFEATED);
            if(slotData.slotState == ClanWarSlotState.IN_BATTLE)
            {
               clip.tf_team_status.text = Translate.translate("UI_CLAN_WAR_TEAM_RENDERER_IN_BATTLE");
            }
            else if(slotData.slotState == ClanWarSlotState.DEFEATED)
            {
               clip.tf_team_status.text = Translate.translate("UI_CLAN_WAR_TEAM_RENDERER_DEFEATED");
            }
            else
            {
               clip.tf_team_status.text = Translate.translate("UI_DEFENDER_TEAM_RENDERER_WAR_TF_TEAM_STATUS");
            }
         }
         else
         {
            clip.layout_points.y = 41;
            if(slotData.slotState == ClanWarSlotState.DEFEATED)
            {
               clip.layout_free.width = 588;
               clip.tf_label_free.text = Translate.translate("UI_DEFENDER_TEAM_RENDERER_WAR_FREE_SLOT_TAKEN");
            }
            else
            {
               clip.layout_free.width = 4;
               clip.tf_label_free.text = Translate.translate("UI_DEFENDER_TEAM_RENDERER_WAR_TF_LABEL_FREE");
            }
         }
      }
      
      private function handler_slotStateChange(param1:ClanWarSlotState = null) : void
      {
         update();
      }
   }
}
