package game.mechanics.clan_war.popup.plan.selectdefender
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mechanics.clan_war.model.ClanWarDefenderValueObject;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.list.ListItemRenderer;
   
   public class ClanWarSelectDefenderRenderer extends ListItemRenderer
   {
       
      
      private var clip:ClanWarSelectDefenderRendererClip;
      
      public function ClanWarSelectDefenderRenderer()
      {
         super();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(clip)
         {
            TooltipHelper.removeTooltip(clip.graphics);
         }
      }
      
      public function get defenderData() : ClanWarDefenderValueObject
      {
         return _data as ClanWarDefenderValueObject;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.clan_war_map.create(ClanWarSelectDefenderRendererClip,"defender_person_renderer");
         addChild(clip.graphics);
         clip.bg_button.signal_click.add(handler_select);
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         if(!defenderData)
         {
            return;
         }
         clip.tf_name.text = !!defenderData.user?defenderData.user.nickname:defenderData.userId;
         clip.tf_power.text = Translate.translate("UI_COMMON_HERO_POWER_COLON") + defenderData.teamPower;
         var _loc1_:TooltipVO = new TooltipVO(ClanWarDefenderTooltipView,defenderData,"TooltipVO.HINT_BEHAVIOR_MOVING");
         TooltipHelper.removeTooltip(clip.graphics);
         TooltipHelper.addTooltip(clip.graphics,_loc1_);
         var _loc2_:* = false;
         clip.player_portrait.graphics.touchable = _loc2_;
         _loc2_ = _loc2_;
         clip.tf_power.graphics.touchable = _loc2_;
         clip.tf_name.graphics.touchable = _loc2_;
         clip.player_portrait.setData(defenderData.user);
         if(defenderData.currentSlot)
         {
            AssetStorage.rsx.popup_theme.setDisabledFilter(clip.player_portrait.graphics,true);
            _loc2_ = 0.3;
            clip.tf_power.alpha = _loc2_;
            clip.tf_name.alpha = _loc2_;
            clip.player_portrait.graphics.alpha = 0.5;
         }
         else
         {
            AssetStorage.rsx.popup_theme.setDisabledFilter(clip.player_portrait.graphics,false);
            _loc2_ = 1;
            clip.tf_power.alpha = _loc2_;
            clip.tf_name.alpha = _loc2_;
            clip.player_portrait.graphics.alpha = 1;
         }
      }
      
      private function handler_select() : void
      {
         dispatchDataEvent("ListItemRenderer.EVENT_SELECT");
      }
   }
}
