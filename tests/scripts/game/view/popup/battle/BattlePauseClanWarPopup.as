package game.view.popup.battle
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.battle.BattlePauseClanWarPopupMediator;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class BattlePauseClanWarPopup extends BattlePausePopup
   {
       
      
      private var _mediator:BattlePauseClanWarPopupMediator;
      
      public function BattlePauseClanWarPopup(param1:BattlePauseClanWarPopupMediator)
      {
         super(param1);
         this._mediator = param1;
      }
      
      override protected function createClip() : void
      {
         clip = AssetStorage.rsx.battle_interface.create_clanWarPausePopup();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:String = "UI_CLAN_WAR_BATTLE_PAUSE_RETREAT_DESCRIPTION";
         if(clip.tf_retreat_description && Translate.has(_loc1_))
         {
            clip.tf_retreat_description.text = Translate.translate(_loc1_);
         }
         if(clip.tf_footer && Translate.has("UI_CLAN_WAR_BATTLE_PAUSE_TIME_LEFT"))
         {
            _mediator.battleTimer.onValue(handler_battleTimer);
         }
         if(clip.tf_retreat_description && clip.tf_footer)
         {
            clip.tf_retreat_description.invalidate();
            clip.tf_footer.invalidate();
            clip.tf_retreat_description.validate();
            clip.tf_footer.validate();
            clip.button_retreat.graphics.y = clip.tf_retreat_description.y + clip.tf_retreat_description.height + 7;
            clip.tf_footer.graphics.y = clip.button_retreat.graphics.y + clip.button_retreat.graphics.height + 3;
            clip.bg.graphics.height = clip.tf_footer.graphics.y + clip.tf_footer.graphics.height - clip.bg.graphics.y + 25;
         }
      }
      
      private function handler_battleTimer(param1:String) : void
      {
         clip.tf_footer.text = Translate.translateArgs("UI_CLAN_WAR_BATTLE_PAUSE_TIME_LEFT",ColorUtils.hexToRGBFormat(16777215) + param1 + ColorUtils.hexToRGBFormat(clip.tf_footer.defaultTextColor));
      }
   }
}
