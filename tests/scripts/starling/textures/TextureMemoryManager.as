package starling.textures
{
   import avmplus.getQualifiedClassName;
   import feathers.controls.Label;
   import feathers.core.DefaultPopUpManager;
   import feathers.core.PopUpManager;
   import flash.utils.Dictionary;
   import org.osflash.signals.Signal;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.filters.BlurFilter;
   import starling.filters.ColorMatrixFilter;
   import starling.filters.FragmentFilter;
   
   public class TextureMemoryManager
   {
      
      public static var MEMORY_ALARM_LIMIT:Number = 5.05413632E8;
      
      private static const counters:Dictionary = new Dictionary();
      
      private static const memory:Dictionary = new Dictionary();
      
      private static const unique:Dictionary = new Dictionary(true);
      
      private static var occupiedMemory:Number = 0;
      
      public static var signal_error:Signal = new Signal(int,String);
      
      public static var signal_memoryAlarm:Signal = new Signal();
       
      
      public function TextureMemoryManager()
      {
         super();
      }
      
      public static function get memoryOccupiedMb() : Number
      {
         return occupiedMemory / 1048576;
      }
      
      public static function addFilter(param1:FragmentFilter, param2:Texture) : void
      {
         add(param2,getFilterName(param1));
      }
      
      public static function add(param1:Texture, param2:String) : void
      {
         param1 = param1.root;
         param1.name = param2;
         var _loc3_:int = param1.nativeWidth * param1.nativeHeight * 4 * 1.5;
         counters[param1.name] = int(counters[param1.name]) + 1;
         memory[param1.name] = int(memory[param1.name]) + _loc3_;
         occupiedMemory = occupiedMemory + _loc3_;
         if(occupiedMemory > MEMORY_ALARM_LIMIT)
         {
            signal_memoryAlarm.dispatch();
         }
         if(!unique[param1])
         {
            unique[param1] = true;
         }
         else
         {
            trace("TextureMemoryManager duplicate add",param1.name);
         }
      }
      
      public static function drop(param1:ConcreteTexture) : void
      {
         var _loc2_:int = param1.nativeWidth * param1.nativeHeight * 4 * 1.5;
         counters[param1.name] = int(counters[param1.name]) - 1;
         memory[param1.name] = int(memory[param1.name]) - _loc2_;
         if(counters[param1.name] == 0)
         {
            delete counters[param1.name];
         }
         if(memory[param1.name] == 0)
         {
            delete memory[param1.name];
         }
         occupiedMemory = occupiedMemory - _loc2_;
         if(unique[param1])
         {
            delete unique[param1];
         }
         else
         {
            trace("TextureMemoryManager duplicate drop",param1.name);
         }
      }
      
      public static function print() : void
      {
      }
      
      public static function getReport() : String
      {
         var _loc2_:Boolean = false;
         _loc2_ = true;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:Array = [];
         var _loc9_:int = 0;
         var _loc8_:* = memory;
         for(var _loc4_ in memory)
         {
            _loc6_ = 0;
            _loc7_ = memory[_loc4_];
            while(_loc6_ < _loc1_.length && memory[_loc1_[_loc6_]] > _loc7_)
            {
               _loc6_++;
            }
            _loc1_.splice(_loc6_,0,_loc4_);
         }
         var _loc3_:String = "";
         var _loc13_:int = 0;
         var _loc12_:* = _loc1_;
         for each(_loc4_ in _loc1_)
         {
            _loc3_ = _loc3_ + ("," + counters[_loc4_] + ":\"" + _loc4_ + "\":" + int(memory[_loc4_] / 1024));
         }
         return "{\'dialogs\':[" + (PopUpManager.forStarling(Starling.current) as DefaultPopUpManager).popUpList + "], \'totalMemory\':" + (occupiedMemory / 1048576).toFixed(2) + "," + _loc3_.slice(1) + "}";
      }
      
      public static function error(param1:int) : void
      {
         signal_error.dispatch(param1,getReport());
      }
      
      private static function getFilterName(param1:FragmentFilter) : String
      {
         var _loc2_:* = null;
         if(param1.target is Label)
         {
            _loc2_ = String((param1.target as Label).text).slice(40);
         }
         else if(param1.target is Image)
         {
            if((param1.target as Image).texture.name)
            {
               _loc2_ = "Image " + (param1.target as Image).texture.name;
            }
            else
            {
               _loc2_ = "Image " + (param1.target as Image).texture.width + "x" + (param1.target as Image).texture.height;
            }
         }
         else
         {
            _loc2_ = getQualifiedClassName(param1.target);
         }
         if(param1 is BlurFilter)
         {
            return "[Blur]:" + _loc2_;
         }
         if(param1 is ColorMatrixFilter)
         {
            return "[Cm]:" + _loc2_;
         }
         return getQualifiedClassName(param1) + ":" + _loc2_;
      }
   }
}
