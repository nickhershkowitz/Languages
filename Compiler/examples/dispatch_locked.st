" Example showing how to use libdispatch directly from Smalltalk.  Invoke with:
  $ edlc -f dispatch.st -l dispatch
"
<< headers='("dispatch/dispatch.h", "unistd.h")' >>
NSObject subclass: SmalltalkTool [
	run [
		| queue count lock |
		lock := NSLock new.
		queue := C dispatch_get_global_queue: { 0. 0 }.
		ETTranscript show: 'main thread' ; cr .
		count := 1.
		1 to: 10 do: [
			C dispatch_async: { queue .
				[
					lock lock.
					ETTranscript show: 'Another thread' ;
					             show: count ; cr . 
					count := count + 1 .
					lock unlock
				] } ] .
		C sleep: 1.
		ETTranscript show: 'Threads used: ' ; show: count ; cr. 
	]
]
