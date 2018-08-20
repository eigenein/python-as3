package game.mediator.gui.popup.team
{
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import game.data.storage.hero.UnitDescription;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.view.popup.PopupBase;
   import game.view.popup.team.MultiTeamGatherPopup;
   
   public class MultiTeamGatherPopupMediator extends TeamGatherPopupMediator
   {
       
      
      protected const _selectedTeam:IntPropertyWriteable = new IntPropertyWriteable(0);
      
      protected var teams:Vector.<Vector.<UnitDescription>>;
      
      public const selectedTeam:IntProperty = _selectedTeam;
      
      public function MultiTeamGatherPopupMediator(param1:Player, param2:Vector.<Vector.<UnitDescription>>)
      {
         var _loc3_:int = 0;
         this.teams = new Vector.<Vector.<UnitDescription>>();
         _loc3_ = 0;
         while(_loc3_ < param2.length)
         {
            this.teams[_loc3_] = param2[_loc3_].concat();
            _loc3_++;
         }
         super(param1,this.teams[0]);
      }
      
      public static function filterMultiTeamHeroesByTeamLevel(param1:Player, param2:Vector.<Vector.<UnitDescription>>, param3:int) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function get descriptions() : Vector.<Vector.<UnitDescription>>
      {
         return teams;
      }
      
      public function get teamCount() : int
      {
         return teams.length;
      }
      
      public function get selectedHeroesCount() : int
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getTeamSize(param1:int) : int
      {
         if(_selectedTeam.value == param1)
         {
            return heroesSelected;
         }
         if(param1 <= teams.length)
         {
            return teams[param1].length;
         }
         return 0;
      }
      
      override public function action_pick(param1:TeamGatherPopupHeroValueObject, param2:Number = 0.2) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      override public function action_complete() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function action_selectTeam(param1:int) : void
      {
         if(param1 < 0 || param1 > 2)
         {
            return;
         }
         selectTeam(teams[param1]);
         _selectedTeam.value = param1;
         updateHeroesList();
      }
      
      public function action_changeTeamIndices(param1:int, param2:int) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new MultiTeamGatherPopup(this);
         return _popup;
      }
      
      override protected function createHeroValueObject(param1:UnitDescription) : TeamGatherPopupHeroValueObject
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      override protected function createEmptyHeroValueObject() : TeamGatherPopupHeroValueObject
      {
         return new MultiTeamGatherPopupHeroValueObject(this,null);
      }
      
      protected function updateSelectedTeam(param1:Vector.<UnitDescription>) : void
      {
         var _loc4_:* = 0;
         var _loc5_:* = null;
         var _loc2_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = teamListDataProvider.getItemAt(_loc4_) as TeamGatherPopupHeroValueObject;
            if(_loc5_.desc != param1[_loc4_])
            {
               _loc5_.heroEntry = player.heroes.getById(param1[_loc4_].id);
               teamListDataProvider.updateItemAt(_loc4_);
            }
            _loc4_++;
         }
         var _loc3_:int = 5;
         _loc4_ = _loc2_;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = teamListDataProvider.getItemAt(_loc4_) as TeamGatherPopupHeroValueObject;
            if(_loc5_.desc != null)
            {
               _loc5_.heroEntry = null;
               teamListDataProvider.updateItemAt(_loc4_);
            }
            _loc4_++;
         }
      }
      
      override protected function updateSelection() : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         var _loc7_:Boolean = false;
         var _loc1_:int = teams.length;
         var _loc4_:Vector.<TeamGatherPopupHeroValueObject> = new Vector.<TeamGatherPopupHeroValueObject>();
         var _loc5_:Vector.<TeamGatherPopupHeroValueObject> = teamListDataProvider.data as Vector.<TeamGatherPopupHeroValueObject>;
         var _loc6_:int = _heroList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc6_)
         {
            _loc3_ = _loc1_;
            _loc7_ = false;
            while(!_loc7_ && _loc3_ > 0)
            {
               if(_loc3_ == _selectedTeam)
               {
                  if(_loc5_.indexOf(_heroList[_loc2_]) != -1)
                  {
                     _loc7_ = true;
                  }
               }
               else if(teams[_loc3_].indexOf(_heroList[_loc2_].desc) != -1)
               {
                  _loc7_ = true;
               }
            }
            _heroList[_loc2_].selected = _loc7_;
            _loc2_++;
         }
      }
      
      override protected function updateCurrentTeamState() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}
