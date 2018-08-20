package idv.cjcat.signals
{
   class ListenerData
   {
       
      
      public var once:Boolean;
      
      public var priority:int;
      
      public var index:int;
      
      public var listener:Function;
      
      function ListenerData(param1:Function, param2:int, param3:Boolean)
      {
         super();
         this.listener = param1;
         this.priority = param2;
         this.once = param3;
      }
   }
}
