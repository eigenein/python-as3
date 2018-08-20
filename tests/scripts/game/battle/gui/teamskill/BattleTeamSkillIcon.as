package game.battle.gui.teamskill
{
   import battle.proxy.CustomAbilityProxy;
   import engine.core.utils.property.BooleanGroupProperty;
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.assets.storage.AssetStorage;
   import starling.display.DisplayObject;
   
   public class BattleTeamSkillIcon
   {
       
      
      private var clip:BattleTeamSkillIconClip;
      
      private var skill:CustomAbilityProxy;
      
      private var progressWhenActivated:Number;
      
      private var deactivated:Boolean = true;
      
      private var intProgress:int = -1;
      
      private var progressTextScale:Number = 1;
      
      private var propertyCanGlow:BooleanProperty;
      
      private var propertyCanUseUlt:BooleanProperty;
      
      private var propertyCanUseAction:BooleanProperty;
      
      private var propertyGroup:BooleanGroupProperty;
      
      public function BattleTeamSkillIcon()
      {
         propertyCanGlow = new BooleanPropertyWriteable(false);
         propertyCanUseUlt = new BooleanPropertyWriteable(false);
         propertyCanUseAction = new BooleanPropertyWriteable(false);
         propertyGroup = new BooleanGroupProperty(propertyCanUseAction,propertyCanUseUlt,propertyCanGlow);
         super();
         clip = new BattleTeamSkillIconClip(false);
      }
      
      public function dispose() : void
      {
         clip.graphics.removeFromParent(true);
      }
      
      public function get graphics() : DisplayObject
      {
         return clip.graphics;
      }
      
      public function setData(param1:CustomAbilityProxy) : void
      {
         var _loc2_:* = null;
         this.skill = param1;
         if(AssetStorage.rsx.battle_interface.data.getClipByName(param1.type) != null)
         {
            AssetStorage.rsx.battle_interface.initGuiClip(clip,param1.type);
            clip.playback.stop();
            clip.ult_deactivate.hide();
            clip.ult_activate.hide();
            clip.ult_active.hide();
            clip.ult_full.hide();
            clip.ult_deactivate.graphics.touchable = false;
            clip.ult_activate.graphics.touchable = false;
            clip.ult_active.graphics.touchable = false;
            clip.ult_full.graphics.touchable = false;
            clip.progressbar_energy.graphics.touchable = false;
            clip.portrait.bg.graphics.touchable = false;
            clip.portrait.portrait.graphics.touchable = false;
            _loc2_ = param1.fx.slice(param1.fx.lastIndexOf("_") + 1);
            clip.portrait.bg.image.texture = AssetStorage.rsx.popup_theme.getTexture("bg_titan_" + _loc2_);
            clip.portrait.frame.image.texture = AssetStorage.rsx.battle_interface.getTexture("border_spirit_" + _loc2_ + "_2");
            clip.portrait.portrait.image.texture = AssetStorage.rsx.battle_interface.getTexture(param1.fx);
            clip.portrait.signal_click.add(handler_click);
         }
         propertyGroup.onValue(clip.setState);
      }
      
      public function tryToActivate() : void
      {
         if(skill != null && skill.action.condition.isEnabled())
         {
            progressWhenActivated = skill.getProgress();
            skill.action.manualTrigger();
            clip.ult_deactivate.show(clip.container);
            clip.ult_deactivate.playOnceAndHide();
            clip.playback.gotoAndPlay(1);
            clip.playback.stopOnFrame(0);
         }
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         clip.forseTimeSync(param1);
         _loc2_ = skill.getProgress();
         clip.progressbar_energy.value = _loc2_;
         propertyCanGlow.value = _loc2_ > 1 && skill.action.condition.enabled;
         propertyCanUseUlt.setValueSilently(skill.action.condition.enabled);
         propertyCanUseAction.value = skill.action.condition.enabled;
         if(_loc2_ > 1)
         {
            updateProgress(_loc2_);
            if(clip.playback.currentFrame == 0)
            {
               clip.tf_multiplier.graphics.alpha = 1;
            }
            var _loc3_:* = progressTextScale;
            clip.tf_multiplier.label.scaleY = _loc3_;
            clip.tf_multiplier.label.scaleX = _loc3_;
            clip.tf_multiplier.label.x = -clip.tf_multiplier.label.width / progressTextScale * (progressTextScale - 1) * 0.5;
            clip.tf_multiplier.label.y = -clip.tf_multiplier.label.height / progressTextScale * (progressTextScale - 1) * 0.5;
            progressTextScale = progressTextScale * 0.5 + 0.5;
         }
         else
         {
            progressTextScale = 1;
            clip.tf_multiplier.text = "";
            clip.tf_multiplier.graphics.alpha = 0;
         }
         clip.portrait.isEnabled = skill.action.condition.isEnabled();
      }
      
      protected function updateProgress(param1:Number) : void
      {
         var _loc2_:int = param1 * 100;
         if(_loc2_ != intProgress)
         {
            intProgress = _loc2_;
            progressTextScale = progressTextScale * 0.5 + 0.65;
            clip.tf_multiplier.text = intProgress + "%";
         }
      }
      
      private function handler_click() : void
      {
         tryToActivate();
      }
   }
}
