package game.command.intern.skin
{
   import game.command.intern.IInternalCommand;
   import game.command.intern.OpenHeroPopUpCommand;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.skin.SkinDescription;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class OpenSkinTabHeroPopUpCommand implements IInternalCommand
   {
       
      
      private var stashParams:PopupStashEventParams;
      
      private var player:Player;
      
      public function OpenSkinTabHeroPopUpCommand(param1:Player, param2:PopupStashEventParams)
      {
         super();
         this.player = param1;
         this.stashParams = param2;
      }
      
      public function execute() : void
      {
         var _loc6_:* = undefined;
         var _loc4_:* = undefined;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:* = null;
         var _loc1_:Vector.<PlayerHeroEntry> = player.heroes.getList();
         if(_loc1_ && _loc1_.length)
         {
            _loc6_ = new Vector.<SkinWithHeroVO>();
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length)
            {
               _loc4_ = DataStorage.skin.getSkinsByHeroId(_loc1_[_loc2_].hero.id);
               _loc3_ = 0;
               while(_loc3_ < _loc4_.length)
               {
                  _loc6_.push(new SkinWithHeroVO(_loc4_[_loc3_],_loc1_[_loc2_]));
                  _loc3_++;
               }
               _loc2_++;
            }
            _loc6_.sort(sortSkinWithHeroList);
            if(_loc6_ && _loc6_.length)
            {
               _loc5_ = new OpenHeroPopUpCommand(player,_loc6_[0].hero.hero,stashParams);
               _loc5_.selectedTab = "TAB_SKINS";
               _loc5_.execute();
            }
         }
      }
      
      private function sortSkinWithHeroList(param1:SkinWithHeroVO, param2:SkinWithHeroVO) : int
      {
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(param1.hero && param2.hero)
         {
            _loc5_ = uint(param1.hero.skinData.getSkinLevelByID(param1.skin.id));
            _loc6_ = uint(param2.hero.skinData.getSkinLevelByID(param2.skin.id));
            _loc4_ = null;
            _loc3_ = null;
            if(_loc5_ < param1.skin.maxLevel)
            {
               _loc4_ = param1.skin.levels[_loc5_].cost;
            }
            if(_loc6_ < param2.skin.maxLevel)
            {
               _loc3_ = param2.skin.levels[_loc6_].cost;
            }
            if(_loc4_ && !_loc3_)
            {
               return -1;
            }
            if(!_loc4_ && _loc3_)
            {
               return 1;
            }
            if(_loc4_ && _loc3_)
            {
               if(player.canSpend(_loc4_) && !player.canSpend(_loc3_))
               {
                  return -1;
               }
               if(!player.canSpend(_loc4_) && player.canSpend(_loc3_))
               {
                  return 1;
               }
               if(param1.skin.isPremium && !param2.skin.isPremium)
               {
                  return -1;
               }
               if(!param1.skin.isPremium && param2.skin.isPremium)
               {
                  return 1;
               }
               if(_loc4_.outputDisplay[0].amount < _loc3_.outputDisplay[0].amount)
               {
                  return 1;
               }
               if(_loc4_.outputDisplay[0].amount > _loc3_.outputDisplay[0].amount)
               {
                  return -1;
               }
               return param2.hero.getPower() - param1.hero.getPower();
            }
         }
         return 0;
      }
   }
}
