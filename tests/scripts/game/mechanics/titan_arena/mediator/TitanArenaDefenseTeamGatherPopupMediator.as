package game.mechanics.titan_arena.mediator
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.hero.UnitDescription;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.mediator.gui.popup.team.TeamGatherHeroBlockReason;
   import game.mediator.gui.popup.team.TeamGatherPopupHeroValueObject;
   import game.mediator.gui.popup.team.TeamGatherPopupMediator;
   import game.model.user.Player;
   import game.model.user.hero.PlayerTitanEntry;
   import game.stat.Stash;
   import game.view.gui.tutorial.Tutorial;
   import game.view.popup.PopupBase;
   
   public class TitanArenaDefenseTeamGatherPopupMediator extends TeamGatherPopupMediator
   {
       
      
      protected var _isTitanTeam:Boolean;
      
      public function TitanArenaDefenseTeamGatherPopupMediator(param1:Player, param2:Vector.<UnitDescription>)
      {
         this._isTitanTeam = true;
         super(param1,param2);
         param1.clan.signal_clanUpdate.add(handler_clanUpdate);
      }
      
      override protected function dispose() : void
      {
         player.clan.signal_clanUpdate.remove(handler_clanUpdate);
         super.dispose();
      }
      
      public function get isTitanTeam() : Boolean
      {
         return _isTitanTeam;
      }
      
      override public function get startButtonLabel() : String
      {
         return Translate.translate("UI_DIALOG_ARENA_DEFENDER_TEAM_GATHER_START");
      }
      
      override public function action_pick(param1:TeamGatherPopupHeroValueObject, param2:Number = 0.2) : void
      {
         if(param1 == null || !param1.isAvailable)
         {
            return;
         }
         super.action_pick(param1,param2);
      }
      
      override public function action_complete() : void
      {
         if(heroesSelected < maxTeamLength)
         {
            PopupList.instance.message(Translate.translate("UI_TITAN_ARENA_NEGATIVE_TEXT_DEFENSE"));
            return;
         }
         _signal_teamGatherComplete.dispatch(this);
         Tutorial.events.triggerEvent_teamSelectionCompleted();
         Stash.click("go",_popup.stashParams);
      }
      
      override public function createPopup() : PopupBase
      {
         var _loc1_:PopupBase = super.createPopup();
         _loc1_.stashParams.windowName = "team_gather:titan_arena_defense";
         return _loc1_;
      }
      
      protected function createTitanList() : Vector.<TeamGatherPopupHeroValueObject>
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      override protected function createHeroList() : Vector.<TeamGatherPopupHeroValueObject>
      {
         var _loc2_:* = undefined;
         _loc2_ = undefined;
         var _loc3_:* = null;
         _loc3_ = null;
         if(_isTitanTeam)
         {
            _loc2_ = createTitanList();
            _loc2_.sort(_sortVoVect);
            var _loc5_:int = 0;
            var _loc4_:* = _loc2_;
            for each(var _loc1_ in _loc2_)
            {
               _loc3_ = isHeroUnavailable(_loc1_);
               if(_loc3_)
               {
                  _loc1_.setUnavailable(_loc3_);
               }
            }
         }
         else
         {
            _loc2_ = player.dungeon.createHeroList(this,player);
            _loc2_.sort(_sortVoVect);
            var _loc7_:int = 0;
            var _loc6_:* = _loc2_;
            for each(_loc1_ in _loc2_)
            {
               _loc3_ = isHeroUnavailable(_loc1_);
               if(_loc3_)
               {
                  _loc1_.setUnavailable(_loc3_);
               }
            }
         }
         return _loc2_;
      }
      
      override public function isHeroUnavailable(param1:TeamGatherPopupHeroValueObject) : TeamGatherHeroBlockReason
      {
         return null;
      }
      
      protected function handler_clanUpdate() : void
      {
         if(player.clan.clan == null)
         {
            close();
         }
      }
   }
}
