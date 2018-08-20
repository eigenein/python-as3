package game.mechanics.clan_war.popup.war.attack
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.HorizontalLayout;
   import game.assets.storage.AssetStorage;
   import game.mechanics.clan_war.mediator.ClanWarSlotState;
   import game.mechanics.clan_war.model.ClanWarSlotValueObject;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.gui.components.tooltip.TooltipTextView;
   
   public class ClanWarAttackListItemRenderer extends ListItemRenderer
   {
       
      
      private var _tooltipValue:TooltipVO;
      
      private var clip:ClanWarAttackListItemRendererClip;
      
      public function ClanWarAttackListItemRenderer()
      {
         super();
      }
      
      override public function dispose() : void
      {
         data = null;
         super.dispose();
      }
      
      override public function set data(param1:Object) : void
      {
         if(slotData)
         {
            slotData.signal_updateTeamHP.remove(handler_teamUpdate);
            slotData.property_clanWarSlotState.signal_update.remove(handler_slotStateChange);
            slotData.property_isTierAvailable.signal_update.remove(handler_tierStateChange);
         }
         .super.data = param1;
         if(slotData)
         {
            slotData.signal_updateTeamHP.add(handler_teamUpdate);
            slotData.property_clanWarSlotState.signal_update.add(handler_slotStateChange);
            slotData.property_isTierAvailable.signal_update.add(handler_tierStateChange);
         }
      }
      
      public function get slotData() : ClanWarSlotValueObject
      {
         return _data as ClanWarSlotValueObject;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.clan_war_map.create(ClanWarAttackListItemRendererClip,"clan_war_team_renderer");
         addChild(clip.graphics);
         clip.button_setup.signal_click.add(handler_select);
         clip.button_attack.signal_click.add(handler_select);
         clip.button_attack.label = Translate.translate("UI_DIALOG_ARENA_ATTACK");
         clip.button_setup.label = Translate.translate("UI_CLAN_WAR_TEAM_RENDERER_GET_POINTS");
         clip.cannot_attack.tf_cannot_attack.text = Translate.translate("UI_CLANWAR_CANNOT_ATTACK_TEXT");
         _tooltipValue = new TooltipVO(TooltipTextView,Translate.translateArgs("UI_CLAN_WAR_VIEW_DEFENCE_PLAN_MEMBER"));
         TooltipHelper.addTooltip(clip.cannot_attack.graphics,_tooltipValue);
         clip.tf_name.maxWidth = 200;
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         if(!slotData)
         {
            return;
         }
         handler_slotStateChange(null);
         _tooltipValue.hintData = "^{252 229 183}^" + Translate.translateArgs("UI_CLAN_WAR_VIEW_DEFENCE_PLAN_MEMBER",slotData.title_leader,slotData.title_warlord);
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
         var _loc7_:Boolean = slotData.team;
         var _loc6_:Boolean = slotData.playerPermission_warrior;
         var _loc3_:* = slotData.slotState == ClanWarSlotState.DEFEATED;
         var _loc5_:Boolean = slotData.slotState == ClanWarSlotState.IN_BATTLE || _loc3_;
         var _loc4_:Boolean = slotData.property_isTierAvailable.value;
         var _loc1_:Boolean = _loc6_ && _loc7_ && _loc4_ && !_loc5_;
         if(slotData.pointsFarmed != slotData.pointsTotal)
         {
            clip.tf_points.text = "+" + slotData.pointsFarmed + "/" + slotData.pointsTotal;
         }
         else
         {
            clip.tf_points.text = "+" + slotData.pointsFarmed;
         }
         clip.layout_none.graphics.visible = slotData.team != null;
         var _loc8_:* = slotData.pointsFarmed > 0;
         clip.layout_points.graphics.visible = _loc8_;
         clip.points_glow.graphics.visible = _loc8_;
         clip.layout_free.graphics.visible = !_loc7_;
         var _loc2_:HorizontalLayout = clip.layout_free.layout as HorizontalLayout;
         _loc2_.paddingRight = 0;
         clip.cannot_attack.graphics.visible = _loc7_ && _loc4_ && !_loc6_;
         clip.button_attack.graphics.visible = _loc1_;
         clip.tf_team_status.graphics.visible = _loc7_ && _loc6_ && (_loc3_ || !_loc4_ || _loc5_);
         if(clip.tf_team_status.graphics.visible)
         {
            if(!_loc4_)
            {
               clip.tf_team_status.text = Translate.translate("UI_CLAN_WAR_TEAM_RENDERER_TIER_LOCKED");
            }
            else if(slotData.slotState == ClanWarSlotState.IN_BATTLE)
            {
               clip.tf_team_status.text = Translate.translate("UI_CLAN_WAR_TEAM_RENDERER_IN_BATTLE");
            }
            else if(slotData.slotState == ClanWarSlotState.DEFEATED)
            {
               clip.tf_team_status.text = Translate.translate("UI_CLAN_WAR_TEAM_RENDERER_DEFEATED");
            }
         }
         if(slotData.team)
         {
            clip.playback.gotoAndStop(0);
         }
         else
         {
            clip.playback.gotoAndStop(1);
            if(slotData.slotState == ClanWarSlotState.DEFEATED)
            {
               _loc2_.paddingRight = 150;
               clip.tf_label_free.text = Translate.translate("UI_CLAN_WAR_TEAM_RENDERER_FREE_SLOT_TAKEN");
               clip.button_setup.graphics.visible = false;
            }
            else if(_loc4_)
            {
               clip.tf_label_free.text = Translate.translate("UI_CLAN_WAR_TEAM_RENDERER_TF_LABEL_FREE");
               clip.button_setup.graphics.visible = _loc6_;
            }
            else
            {
               clip.tf_label_free.text = Translate.translate("UI_CLAN_WAR_TEAM_RENDERER_FREE_TIER_LOCKED");
               clip.button_setup.graphics.visible = false;
            }
         }
         if(slotData.team)
         {
            clip.team.setUnitTeam(slotData.team,slotData.defender.hpPercentState);
         }
      }
      
      private function handler_tierStateChange(param1:Boolean) : void
      {
         update();
      }
      
      private function handler_slotStateChange(param1:ClanWarSlotState = null) : void
      {
         update();
      }
      
      private function handler_select() : void
      {
         dispatchDataEvent("ListItemRenderer.EVENT_SELECT");
      }
      
      private function handler_teamUpdate(param1:ClanWarSlotValueObject) : void
      {
         update();
      }
   }
}
