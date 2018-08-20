package game.mechanics.titan_arena.mediator
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.hero.UnitDescription;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.mediator.gui.popup.team.TeamGatherHeroBlockReason;
   import game.mediator.gui.popup.team.TeamGatherPopupHeroValueObject;
   import game.model.user.Player;
   import game.model.user.hero.PlayerTitanEntry;
   import game.stat.Stash;
   import game.view.gui.tutorial.Tutorial;
   import game.view.popup.PopupBase;
   
   public class TitanArenaRaidAttackTeamGatherPopupMediator extends TitanArenaDefenseTeamGatherPopupMediator
   {
       
      
      public function TitanArenaRaidAttackTeamGatherPopupMediator(param1:Player, param2:Vector.<UnitDescription>)
      {
         super(param1,param2);
      }
      
      override public function action_complete() : void
      {
         _signal_teamGatherComplete.dispatch(this);
         Tutorial.events.triggerEvent_teamSelectionCompleted();
         Stash.click("go",_popup.stashParams);
      }
      
      override public function createPopup() : PopupBase
      {
         var _loc1_:PopupBase = super.createPopup();
         _loc1_.stashParams.windowName = "team_gather:titan_arena_raid_attack";
         return _loc1_;
      }
      
      override protected function createHeroList() : Vector.<TeamGatherPopupHeroValueObject>
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      override public function isHeroUnavailable(param1:TeamGatherPopupHeroValueObject) : TeamGatherHeroBlockReason
      {
         return null;
      }
   }
}
