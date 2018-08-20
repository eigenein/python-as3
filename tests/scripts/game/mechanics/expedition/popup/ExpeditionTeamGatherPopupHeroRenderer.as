package game.mechanics.expedition.popup
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.team.TeamGatherPopupHeroValueObject;
   import game.util.NumberUtils;
   import game.view.popup.team.TeamGatherPopupHeroRenderer;
   
   public class ExpeditionTeamGatherPopupHeroRenderer extends TeamGatherPopupHeroRenderer
   {
       
      
      private var clip:ExpeditionTeamGatherPopupHeroRendererClip;
      
      public function ExpeditionTeamGatherPopupHeroRenderer()
      {
         clip = new ExpeditionTeamGatherPopupHeroRendererClip();
         super();
      }
      
      override public function dispose() : void
      {
         unsubscribe();
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         AssetStorage.rsx.dialog_expedition.initGuiClip(clip,"expedition_team_gather_hero_clip");
         clip.layout_back.includeInLayout = false;
         addChildAt(clip.layout_back,0);
         addChild(clip.graphics);
         clip.layout_back.touchable = false;
         clip.graphics.touchable = false;
         button.height = 124;
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:ExpeditionTeamGatherHeroValueObject = data as ExpeditionTeamGatherHeroValueObject;
         if(_loc2_)
         {
            unsubscribe();
         }
         .super.data = param1;
         _loc2_ = data as ExpeditionTeamGatherHeroValueObject;
         if(_loc2_)
         {
            _loc2_.highLightValue.signal_update.add(handler_hightLightValue);
            clip.tf_power.text = NumberUtils.numberToString(_loc2_.power);
            _loc2_.property_isAvailable.signal_update.add(handler_isAvailable);
         }
      }
      
      override protected function updateState(param1:TeamGatherPopupHeroValueObject) : void
      {
         var _loc4_:ExpeditionTeamGatherHeroValueObject = param1 as ExpeditionTeamGatherHeroValueObject;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc2_:Boolean = _loc4_.isAvailable;
         var _loc3_:Boolean = _loc4_.selected;
         button.isEnabled = _loc2_;
         checkIcon.visible = _loc3_;
         portrait.shadingDisabledProgress;
         portrait.disabled = _loc3_ || !_loc2_;
         portrait.visible = _loc4_.isOwned;
         emptySlot.visible = !portrait.visible;
         clip.panel_timer.graphics.visible = _loc4_.isBusy;
         clip.tf_timer.graphics.visible = _loc4_.isBusy;
         if(_loc4_.isBusy)
         {
            handler_timer();
            _loc4_.signal_timer.add(handler_timer);
         }
         else
         {
            _loc4_.signal_timer.remove(handler_timer);
         }
         clip.panel_power.graphics.visible = _loc4_.isOwned;
         clip.layout_power.graphics.visible = _loc4_.isOwned;
         updateHighlight();
      }
      
      protected function unsubscribe() : void
      {
         var _loc1_:ExpeditionTeamGatherHeroValueObject = data as ExpeditionTeamGatherHeroValueObject;
         if(_loc1_)
         {
            _loc1_.highLightValue.unsubscribe(handler_hightLightValue);
            _loc1_.signal_timer.remove(handler_timer);
            _loc1_.property_isAvailable.unsubscribe(handler_isAvailable);
         }
      }
      
      protected function updateHighlight() : void
      {
         var _loc3_:int = 0;
         var _loc2_:ExpeditionTeamGatherHeroValueObject = data as ExpeditionTeamGatherHeroValueObject;
         var _loc1_:* = 1;
         if(_loc2_)
         {
            _loc3_ = _loc2_.highLightValue.value;
            if(!_loc2_.isAvailable || _loc2_.selected)
            {
               _loc1_ = 0.5;
            }
            else
            {
               switch(int(_loc3_))
               {
                  case 0:
                     portrait.shadingDisabledProgress = 1;
                     _loc1_ = 1;
                     break;
                  case 1:
                  case 2:
                  case 3:
                     portrait.shadingDisabledProgress = 0.75;
                     _loc1_ = 0.4;
               }
            }
         }
         else
         {
            _loc3_ = 0;
         }
         clip.panel_power.graphics.alpha = _loc1_;
         clip.layout_power.graphics.alpha = _loc1_;
         switch(int(_loc3_))
         {
            case 0:
            case 1:
            case 2:
            case 3:
               clip.highlight.graphics.alpha = 0;
         }
      }
      
      private function handler_timer() : void
      {
         var _loc1_:ExpeditionTeamGatherHeroValueObject = data as ExpeditionTeamGatherHeroValueObject;
         if(_loc1_)
         {
            if(_loc1_.isWaitingForRewardToCollect)
            {
               clip.tf_timer.text = Translate.translate("UI_DIALOG_EXPEDITION_GET_YOUR_REWARD");
            }
            else
            {
               clip.tf_timer.text = _loc1_.timeLeft;
            }
         }
      }
      
      private function handler_hightLightValue(param1:int) : void
      {
         updateHighlight();
      }
      
      private function handler_isAvailable(param1:Boolean) : void
      {
         updateState(data as ExpeditionTeamGatherHeroValueObject);
      }
   }
}
