package battle.skills
{
   import battle.Hero;
   import flash.Boot;
   
   public class HeroCollection
   {
       
      
      public var length:int;
      
      public var index:int;
      
      public var heroes:Vector.<Hero>;
      
      public var filterAvailableOnly:Boolean;
      
      public function HeroCollection(param1:Vector.<Hero> = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         heroes = param1;
         index = 0;
         length = int(param1.length);
         filterAvailableOnly = false;
      }
      
      public function next() : Hero
      {
         var _loc2_:int = index;
         index = index + 1;
         var _loc1_:int = _loc2_;
         return heroes[_loc1_];
      }
      
      public function hasNext() : Boolean
      {
         return index < length && (filterAvailableOnly || heroes[index].get_isAvailable());
      }
      
      public function available() : HeroCollectionAvailableIterator
      {
         return new HeroCollectionAvailableIterator(this);
      }
   }
}
