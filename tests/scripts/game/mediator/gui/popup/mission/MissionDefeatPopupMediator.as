package game.mediator.gui.popup.mission
{
   import feathers.core.PopUpManager;
   import game.assets.storage.AssetStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.mechanic.MechanicDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.popup.GamePopupManager;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.arena.BattleResultValueObject;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.mediator.gui.popup.titan.TitanEntryValueObject;
   import game.model.user.Player;
   import game.model.user.hero.HeroEntry;
   import game.model.user.hero.TitanEntry;
   import game.model.user.hero.UnitEntry;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.fightresult.pve.MissionDefeatPopup;
   import game.view.popup.fightresult.pve.defeatpopuprenderers.ImprovementRenderer1;
   import game.view.popup.fightresult.pve.defeatpopuprenderers.ImprovementRenderer2;
   import game.view.popup.fightresult.pve.defeatpopuprenderers.ImprovementRenderer3;
   import game.view.popup.fightresult.pve.defeatpopuprenderers.ImprovementRenderer4;
   import game.view.popup.fightresult.pve.defeatpopuprenderers.ImprovementRenderer5;
   import game.view.popup.fightresult.pve.defeatpopuprenderers.ImprovementRenderer6;
   import game.view.popup.fightresult.pve.defeatpopuprenderers.ImprovementRenderer7;
   import game.view.popup.statistics.BattleStatisticsPopup;
   
   public class MissionDefeatPopupMediator extends PopupMediator
   {
       
      
      private var weakestUnit:UnitEntry;
      
      private var result:BattleResultValueObject;
      
      private var mechanics:MechanicDescription;
      
      private var _adviceList:Vector.<MissionDefeatPopupAdviceValueObject>;
      
      private var _titanAdviceList:Vector.<MissionDefeatPopupAdviceValueObject>;
      
      public function MissionDefeatPopupMediator(param1:Player, param2:BattleResultValueObject, param3:MechanicDescription)
      {
         super(param1);
         this.result = param2;
         this.mechanics = param3;
      }
      
      public function get adviceList() : Vector.<MissionDefeatPopupAdviceValueObject>
      {
         return _adviceList;
      }
      
      public function get titanAdviceList() : Vector.<MissionDefeatPopupAdviceValueObject>
      {
         return _titanAdviceList;
      }
      
      public function get randomAdvice() : MissionDefeatPopupAdviceValueObject
      {
         var _loc1_:* = 0;
         if(weakestUnit is TitanEntry)
         {
            _loc1_ = uint(Math.round(Math.random() * (titanAdviceList.length - 1)));
            return titanAdviceList[_loc1_];
         }
         _loc1_ = uint(Math.round(Math.random() * (adviceList.length - 1)));
         return adviceList[_loc1_];
      }
      
      public function get timeIsUp() : Boolean
      {
         return !!result?result.timeIsUp:false;
      }
      
      public function get mechanicsType() : String
      {
         return mechanics.type;
      }
      
      private function get weakestHero() : HeroDescription
      {
         if(weakestUnit is HeroEntry)
         {
            return (weakestUnit as HeroEntry).hero;
         }
         return null;
      }
      
      private function get weakestTitan() : TitanDescription
      {
         if(weakestUnit is TitanEntry)
         {
            return (weakestUnit as TitanEntry).titan;
         }
         return null;
      }
      
      public function action_createAdviceList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         _titanAdviceList = new Vector.<MissionDefeatPopupAdviceValueObject>();
         _titanAdviceList.push(new MissionDefeatPopupAdviceValueObject(action_titanInfo,AssetStorage.rsx.dialog_battle_defeat.create(ImprovementRenderer6,"improvement_renderer_6")));
         _titanAdviceList.push(new MissionDefeatPopupAdviceValueObject(action_titanInfo,AssetStorage.rsx.dialog_battle_defeat.create(ImprovementRenderer7,"improvement_renderer_7")));
         _adviceList = new Vector.<MissionDefeatPopupAdviceValueObject>();
         _adviceList.push(new MissionDefeatPopupAdviceValueObject(action_evolve,AssetStorage.rsx.dialog_battle_defeat.create(ImprovementRenderer1,"improvement_renderer_1")));
         _adviceList.push(new MissionDefeatPopupAdviceValueObject(action_promote,AssetStorage.rsx.dialog_battle_defeat.create(ImprovementRenderer2,"improvement_renderer_2")));
         _adviceList.push(new MissionDefeatPopupAdviceValueObject(action_skills,AssetStorage.rsx.dialog_battle_defeat.create(ImprovementRenderer3,"improvement_renderer_3")));
         if(player.levelData.level.level >= MechanicStorage.ENCHANT.teamLevel && MechanicStorage.ENCHANT.enabled)
         {
            _adviceList.push(new MissionDefeatPopupAdviceValueObject(action_runes,AssetStorage.rsx.dialog_battle_defeat.create(ImprovementRenderer4,"improvement_renderer_4")));
         }
         if(player.levelData.level.level >= MechanicStorage.BOSS.teamLevel && MechanicStorage.BOSS.enabled)
         {
            _adviceList.push(new MissionDefeatPopupAdviceValueObject(action_skins,AssetStorage.rsx.dialog_battle_defeat.create(ImprovementRenderer5,"improvement_renderer_5")));
         }
         weakestUnit = null;
         if(result && result.result && result.result.attackers)
         {
            _loc1_ = result.result.attackers.length;
            _loc2_ = null;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               if(result.result.attackers[_loc3_] is HeroEntryValueObject)
               {
                  _loc2_ = (result.result.attackers[_loc3_] as HeroEntryValueObject).heroEntry;
               }
               else if(result.result.attackers[_loc3_] is TitanEntryValueObject)
               {
                  _loc2_ = (result.result.attackers[_loc3_] as TitanEntryValueObject).titanEntry;
               }
               if(_loc2_)
               {
                  if(!weakestUnit)
                  {
                     weakestUnit = _loc2_;
                  }
                  else if(weakestUnit.getPower() > _loc2_.getPower())
                  {
                     weakestUnit = _loc2_;
                  }
               }
               _loc3_++;
            }
         }
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new MissionDefeatPopup(this);
         _popup.stashParams.windowName = "mission_defeat";
         return _popup;
      }
      
      public function action_titanInfo() : void
      {
         GamePopupManager.closeAll();
         if(weakestTitan)
         {
            PopupList.instance.dialog_titan(weakestTitan);
         }
         else
         {
            Game.instance.navigator.navigateToTitans(Stash.click("titans",_popup.stashParams));
         }
      }
      
      public function action_evolve() : void
      {
         GamePopupManager.closeAll();
         if(weakestHero)
         {
            PopupList.instance.dialog_hero(weakestHero);
         }
         else
         {
            Game.instance.navigator.navigateToMechanic(MechanicStorage.SKILLS,_popup.stashParams);
         }
      }
      
      public function action_promote() : void
      {
         GamePopupManager.closeAll();
         if(weakestHero)
         {
            PopupList.instance.dialog_hero(weakestHero);
         }
         else
         {
            Game.instance.navigator.navigateToMechanic(MechanicStorage.SKILLS,_popup.stashParams);
         }
      }
      
      public function action_skills() : void
      {
         GamePopupManager.closeAll();
         if(weakestHero)
         {
            PopupList.instance.dialog_hero(weakestHero);
         }
         else
         {
            Game.instance.navigator.navigateToMechanic(MechanicStorage.SKILLS,_popup.stashParams);
         }
      }
      
      public function action_runes() : void
      {
         if(weakestHero && player.clan.clan)
         {
            GamePopupManager.closeAll();
            PopupList.instance.dialog_runes(weakestHero,Stash.click("hero_runes",_popup.stashParams));
         }
         else
         {
            GamePopupManager.closeAll();
            Game.instance.navigator.navigateToMechanic(MechanicStorage.ENCHANT,_popup.stashParams);
         }
      }
      
      public function action_skins() : void
      {
         GamePopupManager.closeAll();
         if(weakestHero)
         {
            PopupList.instance.dialog_hero(weakestHero,"TAB_SKINS");
         }
      }
      
      public function action_showStats() : void
      {
         PopUpManager.addPopUp(new BattleStatisticsPopup(result.attackerTeamStats,result.defenderTeamStats));
      }
   }
}
