package game.data.storage.rule
{
   public class PersonalMerchantValueObject
   {
       
      
      private var _lifetime:int;
      
      private var _dailyLimit:int;
      
      private var _minVipLevel:int;
      
      private var _minChance:Number;
      
      private var _chanceDelimiter:int;
      
      private var _dressInstantly:Boolean;
      
      private var _useSidebarIcon:Boolean;
      
      public function PersonalMerchantValueObject(param1:Object)
      {
         super();
         _lifetime = param1["lifetime"];
         _dailyLimit = param1["dailyLimit"];
         _minVipLevel = param1["minVipLevel"];
         _minChance = param1["minChance"];
         _chanceDelimiter = param1["chanceDelimiter"];
         _dressInstantly = param1["dressInstantly"];
         _useSidebarIcon = param1["useSidebarIcon"];
      }
      
      public function get lifetime() : int
      {
         return _lifetime;
      }
      
      public function get dailyLimit() : int
      {
         return _dailyLimit;
      }
      
      public function get minVipLevel() : int
      {
         return _minVipLevel;
      }
      
      public function get minChance() : Number
      {
         return _minChance;
      }
      
      public function get chanceDelimiter() : int
      {
         return _chanceDelimiter;
      }
      
      public function get dressInstantly() : Boolean
      {
         return _dressInstantly;
      }
      
      public function get useSidebarIcon() : Boolean
      {
         return _useSidebarIcon;
      }
   }
}
