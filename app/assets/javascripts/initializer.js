const pageAccessedByReload = (
    (window.performance.navigation && window.performance.navigation.type === 1) ||
    window.performance
        .getEntriesByType('navigation')
        .map((nav) => nav.type)
        .includes('reload')
);

if(pageAccessedByReload==true){
    console.log("I am initializer");
    localStorage.setItem('buttonpressed', 'false');
}
