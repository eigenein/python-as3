package game.command.rpc.clan.value
{
   import game.data.storage.DataStorage;
   
   public class ClanIconValueObject
   {
       
      
      private var _flagColor1:int = 2;
      
      private var _flagColor2:int = 4;
      
      private var _flagShape:int = 0;
      
      private var _iconColor:int = 0;
      
      private var _iconShape:int = 0;
      
      public function ClanIconValueObject()
      {
         super();
      }
      
      public static function fromRawData(param1:*) : ClanIconValueObject
      {
         var _loc2_:ClanIconValueObject = new ClanIconValueObject();
         _loc2_._flagColor1 = param1.flagColor1;
         _loc2_._flagColor2 = param1.flagColor2;
         _loc2_._flagShape = param1.flagShape;
         _loc2_._iconColor = param1.iconColor;
         _loc2_._iconShape = param1.iconShape;
         return _loc2_;
      }
      
      public static function random() : ClanIconValueObject
      {
         var _loc1_:ClanIconValueObject = new ClanIconValueObject();
         _loc1_._flagColor1 = DataStorage.clanIcon.randomColor;
         _loc1_._flagColor2 = DataStorage.clanIcon.randomColor;
         _loc1_._flagShape = DataStorage.clanIcon.randomPattern;
         _loc1_._iconColor = DataStorage.clanIcon.randomColor;
         _loc1_._iconShape = DataStorage.clanIcon.randomIcon;
         return _loc1_;
      }
      
      public static function iconNull() : ClanIconValueObject
      {
         var _loc1_:ClanIconValueObject = new ClanIconValueObject();
         var _loc2_:* = 0;
         _loc1_._iconShape = _loc2_;
         _loc2_ = _loc2_;
         _loc1_._iconColor = _loc2_;
         _loc2_ = _loc2_;
         _loc1_._flagShape = _loc2_;
         _loc2_ = _loc2_;
         _loc1_._flagColor2 = _loc2_;
         _loc1_._flagColor1 = _loc2_;
         return _loc1_;
      }
      
      public function get flagColor1() : int
      {
         return _flagColor1;
      }
      
      public function get flagColor2() : int
      {
         return _flagColor2;
      }
      
      public function get flagShape() : int
      {
         return _flagShape;
      }
      
      public function get iconColor() : int
      {
         return _iconColor;
      }
      
      public function get iconShape() : int
      {
         return _iconShape;
      }
      
      public function setup(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         _flagColor1 = param1;
         _flagColor2 = param2;
         _flagShape = param3;
         _iconColor = param4;
         _iconShape = param5;
      }
      
      public function serialize() : Object
      {
         return {
            "flagColor1":_flagColor1,
            "flagColor2":_flagColor2,
            "flagShape":_flagShape,
            "iconColor":_iconColor,
            "iconShape":_iconShape
         };
      }
   }
}
