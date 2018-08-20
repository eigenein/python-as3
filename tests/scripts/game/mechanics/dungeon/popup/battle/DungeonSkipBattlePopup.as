package game.mechanics.dungeon.popup.battle
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mechanics.dungeon.mediator.DungeonSkipBattlePopupMediator;
   import game.view.popup.ClipBasedPopup;
   
   public class DungeonSkipBattlePopup extends ClipBasedPopup
   {
       
      
      private var mediator:DungeonSkipBattlePopupMediator;
      
      private var clip:DungeonSkipBattlePopupClip;
      
      public function DungeonSkipBattlePopup(param1:DungeonSkipBattlePopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.dungeon_floors.create(DungeonSkipBattlePopupClip,"dialog_dungeon_skip_battle");
         addChild(clip.graphics);
         clip.button_confirm.initialize(Translate.translate("UI_DIALOG_DUNGEON_SKIP_BATTLE_CONFIRM"),mediator.action_confirm);
         clip.button_decline.initialize(Translate.translate("UI_DIALOG_DUNGEON_SKIP_BATTLE_DECLINE"),mediator.action_decline);
         clip.tf_header.text = Translate.translate("UI_DIALOG_DUNGEON_SKIP_BATTLE_HEADER");
         clip.team.setUnitTeam(mediator.team);
      }
   }
}
