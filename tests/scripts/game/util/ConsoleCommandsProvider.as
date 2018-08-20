package game.util
{
   import com.progrestar.common.Logger;
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   
   public class ConsoleCommandsProvider
   {
       
      
      protected var commands:Dictionary;
      
      protected var commandsAlphabetic:Vector.<ConsoleCommand>;
      
      protected var lastCommands:Vector.<String>;
      
      protected var lastCommandsIndex:int;
      
      private var lastSimilarIndex:int;
      
      private var lastSimilarInput:String;
      
      private var lastSimilarResult:String;
      
      public function ConsoleCommandsProvider()
      {
         super();
         commands = new Dictionary();
         commandsAlphabetic = new Vector.<ConsoleCommand>();
         lastCommands = ConsoleSOStorage.instance.getLastCommands();
         lastCommandsIndex = lastCommands.length;
      }
      
      public function addCommands(param1:Object) : void
      {
         var _loc5_:* = null;
         var _loc2_:XMLList = describeType(param1)..method;
         var _loc9_:int = 0;
         var _loc8_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            var _loc7_:int = 0;
            var _loc6_:* = _loc3_.metadata;
            for each(var _loc4_ in _loc3_.metadata)
            {
               if(_loc4_.@name == "Console")
               {
                  _loc5_ = ConsoleCommand.fromXML(param1,_loc3_,_loc4_);
                  commands[_loc5_.name] = _loc5_;
                  commandsAlphabetic.push(_loc5_);
                  break;
               }
            }
         }
         commandsAlphabetic.sort(ConsoleCommand.sortingFunction);
      }
      
      public function output() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = commandsAlphabetic.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            Logger.getLogger("console::commands").debug(commandsAlphabetic[_loc2_].name + "" + commandsAlphabetic[_loc2_].argsPrompt);
            _loc2_++;
         }
      }
      
      public function askSimilarCommand(param1:String) : String
      {
         if(param1.length == 0)
         {
            return null;
         }
         if(param1 == lastSimilarResult)
         {
            lastSimilarIndex = lastSimilarIndex + 1;
            lastSimilarResult = askSimilar(lastSimilarInput,lastSimilarIndex + 1);
         }
         else
         {
            lastSimilarIndex = 0;
            lastSimilarInput = param1;
            lastSimilarResult = askSimilar(param1);
         }
         return lastSimilarResult;
      }
      
      public function askPreviousCommand() : String
      {
         if(lastCommandsIndex - 1 > -1)
         {
            lastCommandsIndex = lastCommandsIndex - 1;
            return lastCommands[lastCommandsIndex - 1].toString();
         }
         return null;
      }
      
      public function askNextCommand() : String
      {
         if(lastCommandsIndex + 1 < lastCommands.length)
         {
            lastCommandsIndex = lastCommandsIndex + 1;
            return lastCommands[lastCommandsIndex + 1].toString();
         }
         return null;
      }
      
      public function execute(param1:String) : String
      {
         if(param1.length == 0)
         {
            return "";
         }
         if(lastCommands.length == 0 || lastCommands[lastCommands.length - 1] != param1)
         {
            lastCommands[lastCommands.length] = param1;
            ConsoleSOStorage.instance.setLastCommands(lastCommands);
         }
         lastCommandsIndex = lastCommands.length;
         var _loc5_:Array = parseConsoleString(param1);
         var _loc2_:Array = _loc5_.slice(1);
         var _loc4_:ConsoleCommand = commands[_loc5_[0]] as ConsoleCommand;
         if(!_loc4_)
         {
            return "Command not found: " + param1;
         }
         var _loc3_:* = "empty";
         var _loc6_:int = _loc2_.indexOf("!");
         if(_loc6_ != -1)
         {
            _loc2_.splice(_loc6_,1);
            _loc3_ = _loc4_.method.apply(this,_loc2_);
            if(_loc3_ == undefined)
            {
               _loc3_ = "";
            }
         }
         else
         {
            try
            {
               _loc3_ = _loc4_.method.apply(this,_loc2_);
               if(_loc3_ == undefined)
               {
                  _loc3_ = "";
               }
            }
            catch(e:*)
            {
               var _loc8_:String = e;
               return _loc8_;
            }
         }
         return _loc3_;
      }
      
      private function askSimilar(param1:String, param2:int = 0) : String
      {
         var _loc5_:int = 0;
         param1 = param1.toLowerCase();
         var _loc3_:Boolean = false;
         var _loc4_:int = commandsAlphabetic.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            if(commandsAlphabetic[_loc5_].name.toLowerCase().indexOf(param1) == 0)
            {
               _loc3_ = true;
               if(param2 == 0)
               {
                  return commandsAlphabetic[_loc5_].name;
               }
               param2--;
            }
            _loc5_++;
         }
         if(_loc3_)
         {
            return askSimilar(param1,param2);
         }
         return null;
      }
      
      private function parseConsoleString(param1:String) : Array
      {
         str = param1;
         addPart = function():void
         {
            if(lastCommand.length > 0)
            {
               result.push(lastCommand);
            }
            lastCommand = "";
            qChar = "";
         };
         var qChars:Array = ["\"","\'"];
         var result:Array = [];
         var max:int = str.length;
         var qChar:String = "";
         var lastCommand:String = "";
         if(max > 0)
         {
            var char:String = str.charAt(0);
            if(qChars.indexOf(char) != -1)
            {
               qChar = char;
            }
         }
         var i:int = 0;
         for(; i < max; i = Number(i) + 1)
         {
            char = str.charAt(i);
            if(qChars.indexOf(char) != -1)
            {
               if(qChar == "")
               {
                  qChar = char;
                  continue;
               }
               if(qChar == char)
               {
                  addPart();
                  continue;
               }
            }
            else
            {
               if(qChar == "" && char == " ")
               {
                  addPart();
                  continue;
               }
               if(char == "\\")
               {
                  if(i + 1 < max)
                  {
                     i = i + 1;
                     char = str.charAt(i + 1);
                     if(char != qChar && qChars.indexOf(char) == -1)
                     {
                        lastCommand = lastCommand + "\\";
                     }
                  }
               }
            }
            lastCommand = lastCommand + char;
         }
         addPart();
         return result;
      }
   }
}

class ConsoleCommand
{
    
   
   public var name:String;
   
   public var method:Function;
   
   public var help:String;
   
   public var args:Vector.<String>;
   
   public var argsPrompt:String;
   
   public var optionalIndex:int;
   
   public var returnString:Boolean;
   
   function ConsoleCommand(param1:Function, param2:String, param3:String, param4:String, param5:Vector.<String>, param6:int = 2147483647)
   {
      var _loc7_:int = 0;
      super();
      this.method = param1;
      this.name = param2;
      this.help = !!param3?param3:"";
      this.args = param5;
      this.optionalIndex = param6;
      returnString = param4 == "String";
      argsPrompt = "";
      if(param5 && param5.length > 0)
      {
         _loc7_ = 0;
         while(_loc7_ < param5.length)
         {
            argsPrompt = argsPrompt + ((_loc7_ > 0?", ":"(") + (_loc7_ < param6?param5[_loc7_]:"<" + param5[_loc7_] + ">"));
            _loc7_++;
         }
         argsPrompt = argsPrompt + ")";
      }
   }
   
   public static function sortingFunction(param1:ConsoleCommand, param2:ConsoleCommand) : int
   {
      var _loc4_:String = param1.name.toLowerCase();
      var _loc3_:String = param2.name.toLowerCase();
      return _loc4_ > _loc3_?1:Number(_loc4_ < _loc3_?-1:0);
   }
   
   public static function fromXML(param1:Object, param2:XML, param3:XML) : ConsoleCommand
   {
      var _loc4_:* = undefined;
      var _loc8_:* = null;
      var _loc11_:int = 0;
      var _loc10_:String = param2.@name;
      var _loc12_:String = param2.@returnType;
      var _loc13_:* = param3.arg;
      var _loc14_:int = 0;
      var _loc16_:* = new XMLList("");
      var _loc5_:String = param3.arg.(@key == "text").@value;
      var _loc6_:* = 2147483647;
      var _loc7_:int = param2.parameter.length();
      if(_loc7_ > 0)
      {
         _loc4_ = new Vector.<String>(_loc7_);
         _loc8_ = "";
         var _loc18_:int = 0;
         var _loc17_:* = param2.parameter;
         for each(var _loc9_ in param2.parameter)
         {
            _loc11_ = _loc9_.@index - 1;
            _loc4_[_loc11_] = _loc9_.@type;
            if(_loc9_.@optional == "true" && _loc11_ < _loc6_)
            {
               _loc6_ = _loc11_;
            }
         }
      }
      return new ConsoleCommand(param1[_loc10_],_loc10_,_loc5_,_loc12_,_loc4_,_loc6_);
   }
}
