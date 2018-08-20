package game.view.popup.test
{
   import by.blooddy.crypto.Base64;
   import flash.utils.ByteArray;
   import game.assets.storage.BattleAssetStorage;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.UnitDescription;
   import game.view.popup.test.grade.BattleTestGradeModel;
   import game.view.popup.test.grade.IntVectorByteArrayEncoder;
   
   public class BattleTestStatsParams
   {
       
      
      public var leftTeam:Vector.<int>;
      
      public var rightTeam:Vector.<int>;
      
      public var gradeLeft:BattleTestGradeModel;
      
      public var gradeRight:BattleTestGradeModel;
      
      public var currentBattlegroundId:int;
      
      public var gradeMode:int;
      
      public var fillEmptySlots:Boolean = false;
      
      public var configIndex:int;
      
      public var skinModeIndex:int;
      
      public var doNotRandomRight:Boolean;
      
      public var selectedHeroTab:int;
      
      public var useInterpreter:Boolean;
      
      public function BattleTestStatsParams()
      {
         leftTeam = new Vector.<int>();
         rightTeam = new Vector.<int>();
         gradeLeft = new BattleTestGradeModel();
         gradeRight = new BattleTestGradeModel();
         useInterpreter = !!BattleAssetStorage.USE_INTERPRETER?true:false;
         super();
      }
      
      public function serialize() : String
      {
         var _loc1_:Vector.<int> = gradeLeft.toVector();
         var _loc2_:Vector.<int> = gradeRight.toVector();
         var _loc3_:String = encodeUriSetupB(leftTeam,rightTeam,_loc1_,_loc2_,serializeParams());
         return _loc3_;
      }
      
      public function deserialize(param1:String) : void
      {
         var _loc2_:* = undefined;
         var _loc4_:* = undefined;
         var _loc6_:* = undefined;
         var _loc3_:Object = decodeUriSetupB(param1);
         if(_loc3_)
         {
            _loc2_ = new Vector.<UnitDescription>();
            _loc4_ = new Vector.<UnitDescription>();
            if(_loc3_.leftTeam)
            {
               var _loc8_:int = 0;
               var _loc7_:* = _loc3_.leftTeam;
               for each(var _loc5_ in _loc3_.leftTeam)
               {
                  _loc2_.push(DataStorage.hero.getUnitById(_loc5_));
               }
            }
            if(_loc3_.rightTeam)
            {
               var _loc10_:int = 0;
               var _loc9_:* = _loc3_.rightTeam;
               for each(_loc5_ in _loc3_.rightTeam)
               {
                  _loc4_.push(DataStorage.hero.getUnitById(_loc5_));
               }
            }
            if(_loc3_.grade_both)
            {
               gradeLeft.deserialize(_loc3_.grade_both);
               gradeRight.deserialize(_loc3_.grade_both);
            }
            else
            {
               if(_loc3_.left)
               {
                  gradeLeft.deserialize(_loc3_.left);
               }
               if(_loc3_.right)
               {
                  gradeRight.deserialize(_loc3_.right);
               }
               else if(_loc3_.left)
               {
                  gradeRight.deserialize(_loc3_.left);
               }
            }
            _loc6_ = _loc3_.params;
            deserializeParams(_loc6_);
         }
      }
      
      private function encodeUriSetupB(param1:Vector.<int>, param2:Vector.<int>, param3:Vector.<int>, param4:Vector.<int>, param5:Vector.<int>) : String
      {
         var _loc7_:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
         _loc7_.push(param1,param2,param3,param4,param5);
         var _loc9_:ByteArray = IntVectorByteArrayEncoder.encode(_loc7_);
         _loc9_.compress();
         var _loc8_:String = Base64.encode(_loc9_);
         var _loc6_:String = encodeURIComponent(_loc8_);
         return _loc6_;
      }
      
      private function decodeUriSetupB(param1:String) : Object
      {
         var _loc4_:* = null;
         var _loc8_:* = null;
         var _loc5_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         try
         {
            _loc4_ = decodeURIComponent(param1);
            _loc8_ = Base64.decode(_loc4_);
            _loc8_.uncompress();
            _loc5_ = new Vector.<int>();
            _loc2_ = new Vector.<int>();
            _loc3_ = new Vector.<int>();
            _loc6_ = new Vector.<int>();
            _loc7_ = new Vector.<int>();
            IntVectorByteArrayEncoder.decode(new <Vector.<int>>[_loc5_,_loc2_,_loc3_,_loc6_,_loc7_],_loc8_);
            var _loc10_:* = {
               "leftTeam":_loc5_,
               "rightTeam":_loc2_,
               "left":_loc3_,
               "right":_loc6_,
               "params":_loc7_
            };
            return _loc10_;
         }
         catch(e:Error)
         {
            var _loc11_:* = null;
            return _loc11_;
         }
      }
      
      private function serializeParams() : Vector.<int>
      {
         return new <int>[currentBattlegroundId,gradeMode,!!fillEmptySlots?1:0,configIndex,skinModeIndex,selectedHeroTab,!!doNotRandomRight?1:0,!!BattleAssetStorage.USE_INTERPRETER?1:0];
      }
      
      private function deserializeParams(param1:Vector.<int>) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:int = param1.length;
         if(_loc2_ > 0)
         {
            currentBattlegroundId = param1[0];
         }
         if(_loc2_ > 1)
         {
            gradeMode = param1[1];
         }
         if(_loc2_ > 2)
         {
            fillEmptySlots = param1[2];
         }
         if(_loc2_ > 3)
         {
            configIndex = param1[3];
         }
         if(_loc2_ > 4)
         {
            skinModeIndex = param1[4];
         }
         if(_loc2_ > 5)
         {
            selectedHeroTab = param1[5];
         }
         if(_loc2_ > 6)
         {
            doNotRandomRight = param1[6];
         }
         if(_loc2_ > 7)
         {
            BattleAssetStorage.USE_INTERPRETER = param1[7];
         }
      }
   }
}
