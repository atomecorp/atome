const view = document.getElementById('view');

function createElement(type, className, attributes = {}, children = []) {
    const element = document.createElement(type);
    if (className) element.className = className;
    Object.keys(attributes).forEach(attr => element.setAttribute(attr, attributes[attr]));
    children.forEach(child => element.appendChild(child));
    return element;
}

function createCheckbox(id, value, labelText, isChecked = true, labelClass = '') {
    const input = createElement('input', labelClass, { type: 'checkbox', id, value });
    input.checked = isChecked;
    const label = createElement('label', `checkbox ${labelClass}`, { htmlFor: id });
    label.textContent = labelText;
    return [input, label];
}

const sidebarItems = [
    { id: 'all', value: 'all', text: 'tout voire', className: 'checkbox-all' },
    { id: '1', value: '1', text: 'personnel', className: 'checkbox-calendar checkbox-1' },
    { id: '2', value: '2', text: 'Travail', className: 'checkbox-calendar checkbox-2' }
];

const sidebarDivs = sidebarItems.map(item => {
    const [input, label] = createCheckbox(item.id, item.value, item.text, true, item.className);
    return createElement('div', 'sidebar-item', {}, [input, label]);
});

const aside = createElement('aside', 'sidebar', { style: 'display: none' }, [
    ...sidebarDivs,
    createElement('hr'),
]);

const dropdownItems = [
    { href: '#', viewName: 'month', text: 'Monthly' },
    { href: '#', viewName: 'week', text: 'Weekly' },
    { href: '#', viewName: 'day', text: 'Daily' }
];

const dropdownContent = dropdownItems.map(item => 
    createElement('a', 'dropdown-item', { href: item.href, 'data-view-name': item.viewName }, [document.createTextNode(item.text)])
);

const dropdown = createElement('div', 'dropdown', {}, [
    createElement('div', 'dropdown-trigger', {}, [
        createElement('button', 'button is-rounded', { 'aria-haspopup': 'true', 'aria-controls': 'dropdown-menu' }, [
            createElement('span', 'button-text'),
            createElement('span', 'dropdown-icon toastui-calendar-icon toastui-calendar-ic-dropdown-arrow')
        ])
    ]),
    createElement('div', 'dropdown-menu', {}, [
        createElement('div', 'dropdown-content', {}, dropdownContent)
    ])
]);

const nav = createElement('nav', 'navbar', { style: 'display: none' }, [
    dropdown,
    createElement('button', 'button is-rounded today', {}, [document.createTextNode('Today')]),
    createElement('button', 'button is-rounded prev', {}, [
        createElement('img', '', { alt: 'prev', src: './images/ic-arrow-line-left.png', srcset: './images/ic-arrow-line-left@2x.png 2x, ./images/ic-arrow-line-left@3x.png 3x' })
    ]),
    createElement('button', 'button is-rounded next', {}, [
        createElement('img', '', { alt: 'next', src: './images/ic-arrow-line-right.png', srcset: './images/ic-arrow-line-right@2x.png 2x, ./images/ic-arrow-line-right@3x.png 3x' })
    ]),
    createElement('span', 'navbar--range'),
    createElement('div', 'nav-checkbox', {}, [
        createElement('input', 'checkbox-collapse', { type: 'checkbox', id: 'collapse', value: 'collapse' }),
        createElement('label', '', { htmlFor: 'collapse' }, [document.createTextNode('Collapse duplicate events and disable the detail popup')])
    ])
]);

const section = createElement('section', 'app-column', {}, [
    nav,
    createElement('main', '', { id: 'app' })
]);

const article = createElement('article', 'content', {}, [
    aside,
    section
]);

const appContainer = createElement('div', 'app-container code-html', { style: 'width: 100%; height: 100%' }, [
    article
]);

view.appendChild(appContainer);