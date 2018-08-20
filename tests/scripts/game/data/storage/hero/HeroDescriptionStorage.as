package game.data.storage.hero
{
   import game.data.storage.DescriptionStorage;
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.popup.hero.UnitUtils;
   
   [Exclude(kind="method",name="getById")]
   public class HeroDescriptionStorage extends DescriptionStorage
   {
       
      
      public function HeroDescriptionStorage()
      {
         super();
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:UnitDescription = UnitUtils.createDescription(param1);
         _items[_loc2_.id] = _loc2_;
      }
      
      public function getUnitById(param1:uint) : UnitDescription
      {
         return _items[param1] as UnitDescription;
      }
      
      public function getHeroById(param1:uint) : HeroDescription
      {
         if(!_items[param1])
         {
            trace("unknown hero id ",param1);
            return _items[1] as HeroDescription;
         }
         return _items[param1] as HeroDescription;
      }
      
      public function getTitanById(param1:uint) : TitanDescription
      {
         return _items[param1] as TitanDescription;
      }
      
      public function getList() : Vector.<UnitDescription>
      {
         var _loc1_:Vector.<UnitDescription> = new Vector.<UnitDescription>();
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for each(var _loc2_ in _items)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function getHeroList() : Vector.<HeroDescription>
      {
         var _loc1_:Vector.<HeroDescription> = new Vector.<HeroDescription>();
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for each(var _loc2_ in _items)
         {
            if(_loc2_ != null && _loc2_.unitType == "hero")
            {
               _loc1_.push(_loc2_ as HeroDescription);
            }
         }
         return _loc1_;
      }
      
      public function getPlayableHeroes() : Vector.<HeroDescription>
      {
         var _loc1_:Vector.<HeroDescription> = new Vector.<HeroDescription>();
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(var _loc2_ in _items)
         {
            if(_loc2_.unitType == "hero" && _loc2_.isPlayable)
            {
               _loc3_++;
               _loc1_[_loc3_] = _loc2_ as HeroDescription;
            }
         }
         return _loc1_;
      }
      
      public function getPlayableTitans() : Vector.<TitanDescription>
      {
         var _loc1_:Vector.<TitanDescription> = new Vector.<TitanDescription>();
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(var _loc2_ in _items)
         {
            if(_loc2_.unitType == "titan" && _loc2_.isPlayable)
            {
               _loc3_++;
               _loc1_[_loc3_] = _loc2_ as TitanDescription;
            }
         }
         return _loc1_;
      }
      
      public function isPlayableHeroId(param1:int) : Boolean
      {
         return param1 < 1000;
      }
   }
}
