package game.data.storage.quest
{
   import game.data.storage.DescriptionStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.HeroRoleDescription;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.titan.TitanDescription;
   import game.model.user.quest.PlayerQuestEntry;
   
   public class QuestHeroAdviceStorage extends DescriptionStorage
   {
       
      
      public function QuestHeroAdviceStorage()
      {
         super();
      }
      
      function getQuestAdvice(param1:PlayerQuestEntry, param2:UnitDescription) : Vector.<QuestHeroAdviceDescription>
      {
         var _loc10_:int = 0;
         var _loc8_:* = null;
         var _loc3_:Vector.<QuestHeroAdviceDescription> = new Vector.<QuestHeroAdviceDescription>();
         var _loc6_:String = param1.desc.translationMethod;
         var _loc4_:HeroRoleDescription = null;
         if(param2 is HeroDescription)
         {
            _loc4_ = (param2 as HeroDescription).role;
         }
         else if(param2 is TitanDescription)
         {
            _loc4_ = (param2 as TitanDescription).role;
         }
         var _loc9_:Array = _loc4_.extendedRoleStringList;
         var _loc7_:Vector.<QuestHeroAdviceDescription> = _items[_loc6_];
         if(!_loc7_)
         {
            return _loc3_;
         }
         var _loc5_:int = _loc7_.length;
         _loc10_ = 0;
         while(_loc10_ < _loc5_)
         {
            _loc8_ = _loc7_[_loc10_];
            if(_loc8_.translated)
            {
               if(_loc8_.hero_id[param2.id])
               {
                  _loc3_.push(_loc8_);
               }
               else if(_loc8_.characterMatch(_loc4_.character))
               {
                  _loc3_.push(_loc8_);
               }
            }
            _loc10_++;
         }
         return _loc3_;
      }
      
      override public function applyLocale() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(var _loc1_ in _items)
         {
            _loc2_ = _loc1_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_[_loc3_].applyLocale();
               _loc3_++;
            }
         }
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc5_:QuestHeroAdviceDescription = new QuestHeroAdviceDescription(param1);
         var _loc2_:int = _loc5_.ident.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _loc5_.ident[_loc4_];
            if(!_items[_loc3_])
            {
               _items[_loc3_] = new Vector.<QuestHeroAdviceDescription>();
            }
            _items[_loc3_].push(_loc5_);
            _loc4_++;
         }
      }
   }
}
